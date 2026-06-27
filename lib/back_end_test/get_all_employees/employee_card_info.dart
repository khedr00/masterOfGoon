class EmployeeCardInfo {
  EmployeeCardInfo({
    required this.employeeId,
    required this.employeeName,
    required this.employeePhoto,
    required this.employeeType,
    required this.employeeLocation,
    required this.productivity,
    this.numberOfTotalDeals,
  });
  final String employeeId;
  final String employeeName;
  final String employeePhoto;
  final String employeeType;
  final String employeeLocation;
  final String productivity;
  final int? numberOfTotalDeals;
}
