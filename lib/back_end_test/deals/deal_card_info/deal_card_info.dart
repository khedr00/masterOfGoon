class DealCardInfo {
  final String id;
  final String propertyPrimaryImage;
  final String propertyType;
  final int propertyPrice;
  final String propertySimpleDescription;
  final String propertyAddress;
  final String clientName;
  final String clientPhoto;
  final String title;
  final String dealStage;
  final int successProbability;
  final String startingDate;
  final int clientId;
  final int propertyId;

  DealCardInfo({
    required this.id,
    required this.propertyId,
    required this.clientId,
    required this.title,
    required this.dealStage,
    required this.successProbability,
    required this.startingDate,
    required this.clientName,
    required this.clientPhoto,
    required this.propertyPrimaryImage,
    required this.propertyType,
    required this.propertyPrice,
    required this.propertySimpleDescription,
    required this.propertyAddress,
  });
}
