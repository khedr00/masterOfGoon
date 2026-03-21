import 'package:untitled1/core/modules/schedule-models/schedule_note.dart';

class ScheduleDealNote extends ScheduleNote {
  ScheduleDealNote({
    required super.id,
    required super.employeeId,
    required super.date,
    required super.time,
    required super.title,
    required super.description,
    required this.dealId,
  });
  final int dealId;
}
