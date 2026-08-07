/// OAuth client IDs for Google Sign-In.
///
/// Setup (Google Cloud Console → APIs & Services → Credentials):
/// 1. Create OAuth client **Android** (package `com.kerjajogja.smart_hydroponic` + SHA-1).
/// 2. Create OAuth client **iOS** (bundle id from Xcode).
/// 3. Create OAuth client **Web** — put that ID in [serverClientId]
///    (required on Android when not using `google-services.json`).
/// 4. iOS: also set `GIDClientID` + `CFBundleURLTypes` in `ios/Runner/Info.plist`
///    using CLIENT_ID / REVERSED_CLIENT_ID from the iOS OAuth client.
///
/// Get Android debug SHA-1:
/// `cd android && ./gradlew signingReport`
abstract final class AuthConfig {
  /// Web application OAuth client ID (also used later as server client for API).
  static const String serverClientId = '';

  /// iOS OAuth client ID. Leave empty if set via Info.plist `GIDClientID`.
  static const String iosClientId = '';

  static String? get resolvedServerClientId =>
      serverClientId.isEmpty ? null : serverClientId;

  static String? get resolvedIosClientId =>
      iosClientId.isEmpty ? null : iosClientId;
}
