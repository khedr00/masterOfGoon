import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_note.dart';

class ScheduleDealNote extends ScheduleNote {
  ScheduleDealNote({
    super.id,
    super.employeeId,
    super.date,
    required super.time,
    required super.title,
    required super.description,
    required this.dealId,
    required this.propertyNameCode,
    required this.dealName,
  });
  final String dealId;
  final String propertyNameCode;
  final String dealName;
}
