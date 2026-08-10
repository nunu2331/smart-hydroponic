import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_hydroponic/auth/auth_config.dart';
import 'package:smart_hydroponic/auth/auth_user.dart';

/// Google Sign-In session. No backend yet — success = local logged-in state.
class AuthService extends ChangeNotifier {
  AuthService._();

  static final AuthService instance = AuthService._();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  AuthUser? _user;
  bool _initialized = false;

  AuthUser? get currentUser => _user;
  bool get isSignedIn => _user != null;
  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    await _googleSignIn.initialize(
      clientId: AuthConfig.resolvedIosClientId,
      serverClientId: AuthConfig.resolvedServerClientId,
    );

    _googleSignIn.authenticationEvents
        .listen(_onAuthEvent)
        .onError((Object error, StackTrace stack) {
          debugPrint('Google auth event error: $error');
        });

    try {
      final future = _googleSignIn.attemptLightweightAuthentication();
      if (future != null) {
        final account = await future;
        if (account != null) {
          _user = _mapAccount(account);
        }
      }
    } catch (error) {
      debugPrint('Lightweight Google auth skipped: $error');
    }

    _initialized = true;
  }

  void _onAuthEvent(GoogleSignInAuthenticationEvent event) {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        _user = _mapAccount(event.user);
        notifyListeners();
      case GoogleSignInAuthenticationEventSignOut():
        _user = null;
        notifyListeners();
    }
  }

  /// Opens the native Google account picker.
  /// Returns the signed-in user, or `null` if the user cancelled.
  ///
  /// When a login API exists, send [AuthUser.idToken] to the server here.
  Future<AuthUser?> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.authenticate(
        scopeHint: const <String>['email', 'profile'],
      );
      _user = _mapAccount(account);
      notifyListeners();
      return _user;
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  /// Email/password UI path — no API yet, treat as logged in locally.
  void signInLocally({required String email, String? name}) {
    final trimmed = email.trim();
    _user = AuthUser(
      id: 'local:$trimmed',
      email: trimmed.isEmpty ? 'guest@local' : trimmed,
      displayName: name?.trim().isNotEmpty == true
          ? name!.trim()
          : (trimmed.isEmpty ? 'Guest' : trimmed),
    );
    notifyListeners();
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }

  AuthUser _mapAccount(GoogleSignInAccount account) {
    return AuthUser(
      id: account.id,
      email: account.email,
      displayName: account.displayName ?? account.email,
      photoUrl: account.photoUrl,
      idToken: account.authentication.idToken,
    );
  }
}
