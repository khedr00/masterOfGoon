import 'package:untitled1/core/modules/property-modules/propetry.dart';

class Deal {
  final int id;
  final Property property;
  final int clientId;
  final int employeeId;
  final String title;
  final String dealStage;
  final int successProbability;
  final String startingDate;
  final List<String> notes;
  final String? meetingDate;

  Deal({
    required this.id,
    required this.property,
    required this.clientId,
    required this.employeeId,
    required this.title,
    required this.dealStage,
    required this.successProbability,
    required this.startingDate,
    required this.notes,
    this.meetingDate,
  });
}
