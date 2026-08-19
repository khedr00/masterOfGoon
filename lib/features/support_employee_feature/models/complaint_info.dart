class ComplaintInfo {
  ComplaintInfo({
    required this.issueMessage,
    required this.email,
    required this.phoneNumber,
  });

  final String issueMessage;
  final String email;
  final String phoneNumber;

  factory ComplaintInfo.fromJson(Map<String, dynamic> json) {
    return ComplaintInfo(
      issueMessage: json['issueMessage'] ?? '',
      email: json['user']?['email'] ?? '',
      phoneNumber: json['user']?['client']?['phone'] ?? '',
    );
  }
}
