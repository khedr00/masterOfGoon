class EmployeeInfo {
  EmployeeInfo({
    required this.employeeName,
    required this.employeeType,
    required this.employeePhoto,
    required this.employeeEmail,
    required this.employeePhoneNumber,
    required this.employeeLocation,
    required this.productivity,
    required this.avgResponseTime,
  });
  final String employeeName;
  final String employeeType;
  final String? employeePhoto;
  final String employeeEmail;
  final String employeePhoneNumber;
  final String employeeLocation;
  final int productivity;
  final int avgResponseTime;
}
