class UserAuthInfo {
  final int id;
  final String role;
  String accessToken;
  final String refreshToken;

  UserAuthInfo({
    required this.id,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  // factory UserAuthInfo.fromJson(Map<String, dynamic> json) {
  //   return UserAuthInfo(
  //     id: json['id'],
  //     role: json['role'],
  //     accessToken: json['accessToken'],
  //     refreshToken: json['refreshToken'],
  //   );
  // }
}
