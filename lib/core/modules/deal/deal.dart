enum DealStage { fresh, negotiation }

class Deal {
  final int id;
  final int propertyId;
  final int clientId;
  final int employeeId;
  final String title;
  final DealStage dealStage;
  final int successProbability;
  final String startingDate;
  final List<String> notes;
  // final String? meetingDate;

  Deal({
    required this.id,
    required this.propertyId,
    required this.clientId,
    required this.employeeId,
    required this.title,
    required this.dealStage,
    required this.successProbability,
    required this.startingDate,
    required this.notes,
    // this.meetingDate,
  });
}
