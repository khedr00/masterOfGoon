class ComplaintCardInfo {
  ComplaintCardInfo({
    required this.complaintId,
    required this.complaintStatus,
    required this.createdAt,
    required this.name,
    required this.code,
    required this.severity,
    required this.userId,
    required this.userRole,
    required this.userName,
    required this.userPhoto,
  });

  final String complaintId;
  final String complaintStatus;
  final String createdAt;
  final String name;
  final String code;
  final String severity;
  final String userId;
  final String userRole;
  final String userName;
  final String userPhoto;

  factory ComplaintCardInfo.fromJson(Map<String, dynamic> json) {
    return ComplaintCardInfo(
      complaintId: json['id'] ?? '',
      complaintStatus: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      name: json['complaintType']?['name'] ?? '',
      code: json['complaintType']?['code'] ?? '',
      severity: json['complaintType']?['severity'] ?? '',
      userId: json['user']?['id'] ?? '',
      userRole: json['user']?['role'] ?? '',
      userName:
          json['user']?['client']?['name'] ??
          json['user']?['employee']?['name'] ??
          '',
      userPhoto:
          json['user']?['client']?['photo'] ??
          json['user']?['employee']?['photo'] ??
          '',
    );
  }
}
