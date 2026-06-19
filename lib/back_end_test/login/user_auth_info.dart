class UserAuthInfo {
  final String id;
  final String role;
  String accessToken;
  final String refreshToken;

  UserAuthInfo({
    required this.id,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserAuthInfo.fromJson(
    Map<String, dynamic> json,
    String refreshToken,
  ) {
    return UserAuthInfo(
      id: json['data']['employee']['id'],
      role: json['data']['employee']['role'],
      accessToken: json['token'],
      refreshToken: refreshToken,
    );
  }
}
