class UserAuthInfo {
  UserAuthInfo({
    required this.id,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });
  final int id;
  final String role;
  final String accessToken;
  final String refreshToken;
}
