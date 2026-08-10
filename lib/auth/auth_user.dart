class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.idToken,
  });

  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;

  /// Google ID token — send to backend when login API exists.
  final String? idToken;

  String get initial {
    final source = displayName.isNotEmpty ? displayName : email;
    return source.isEmpty ? '?' : source[0].toUpperCase();
  }

  String get name => displayName.isNotEmpty ? displayName : email;
}
