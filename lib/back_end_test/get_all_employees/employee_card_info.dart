class EmployeeCardInfo {
  EmployeeCardInfo({
    required this.employeeId,
    required this.employeeName,
    required this.employeePhoto,
    required this.employeeType,
    required this.employeeLocation,
    required this.productivity,
    required this.numberOfTotalDeals,
  });
  final String employeeId;
  final String employeeName;
  final String employeePhoto;
  final String employeeType;
  final String employeeLocation;
  final String productivity;
  final int numberOfTotalDeals;
  factory EmployeeCardInfo.fromJson(Map<String, dynamic> json) {
    return EmployeeCardInfo(
      employeeId: json['id'] ?? '',
      employeeName: json['fullName'] ?? '',
      employeePhoto: json['photo'] ?? '',
      employeeType: json['role'] ?? '',
      employeeLocation: json['location'] ?? '',
      productivity: (json['productivity'] ?? 0).toString(),
      numberOfTotalDeals: json['totalDeals'],
    );
  }
}
