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
  final int dealId;
  final String propertyNameCode;
  final String dealName;

  String getDealNoteTitle() {
    // استعداء الأجرائية اللي بتجبلي عنوان الصفقة حسب الآي دي
    return "Request to Buy Property _ Homs City";
  }

  String getDealNotePropertyNamecode() {
    // استعداء الأجرائية اللي بتجبلي النيم كود للبروبرتي حسب الديل آي دي
    return "V-243";
  }
}
