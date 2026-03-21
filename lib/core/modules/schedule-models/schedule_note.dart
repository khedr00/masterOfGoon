class ScheduleNote {
  final int id;
  final int employeeId;
  final String date;
  final String time;
  final String title;
  final String description;

  ScheduleNote({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.time,
    required this.title,
    required this.description,
  });
}
