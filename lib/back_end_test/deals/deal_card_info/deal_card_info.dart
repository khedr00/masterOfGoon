class DealCardInfo {
  final int id;
  final int propertyId;
  final int clientId;
  final String title;
  final String dealStage;
  final int successProbability;
  final String startingDate;

  DealCardInfo({
    required this.id,
    required this.propertyId,
    required this.clientId,
    required this.title,
    required this.dealStage,
    required this.successProbability,
    required this.startingDate,
  });
}
