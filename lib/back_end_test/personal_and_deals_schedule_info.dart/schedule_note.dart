class ScheduleNote {
  final int? id;
  final int? employeeId;
  final String? date;
  final String time;
  final String title;
  final String description;

  ScheduleNote({
    this.id,
    this.employeeId,
    this.date,
    required this.time,
    required this.title,
    required this.description,
  });
}
