class EmployeeCardInfo {
  EmployeeCardInfo({
    required this.employeeId,
    required this.employeeName,
    required this.employeePhoto,
    required this.employeeEmail,
    required this.employeeType,
    required this.employeeLocation,
    required this.productivity,
    required this.numberOfTotalDeals,
  });
  final String employeeId;
  final String employeeName;
  final String employeePhoto;
  final String employeeEmail;
  final String employeeType;
  final String employeeLocation;
  final String productivity;
  final int numberOfTotalDeals;

  factory EmployeeCardInfo.fromJson(Map<String, dynamic> json) {
    final user = Map<String, dynamic>.from(json['user'] as Map? ?? {});

    return EmployeeCardInfo(
      employeeId: json['id']?.toString() ?? '',
      employeeName: json['fullName']?.toString() ?? '',
      employeePhoto: json['photo']?.toString() ?? '',
      employeeEmail:
          user['email']?.toString() ?? json['email']?.toString() ?? '',
      employeeType: json['role']?.toString() ?? '',
      employeeLocation: json['location']?.toString() ?? '',
      productivity: (json['productivity'] ?? 0).toString(),
      numberOfTotalDeals: (json['totalDeals'] as num?)?.toInt() ?? 0,
    );
  }
}
