class DealRequestCardInfo {
  DealRequestCardInfo({
    required this.referenceCode,
    required this.listedPrice,
    required this.type,
    required this.clientName,
    required this.leadScoring,
    required this.message,
    required this.location,
    required this.simpleDescription,
    required this.id,
  });

  final String referenceCode;
  final String listedPrice;
  final String type;
  final String clientName;
  final String leadScoring;
  final String message;
  final String location;
  final String simpleDescription;
  final String id;

  factory DealRequestCardInfo.fromJson(Map<String, dynamic> json) {
    return DealRequestCardInfo(
      referenceCode: json['property']['referenceCode'] ?? '',
      listedPrice: json['property']['listedPrice'].toString(),
      type: json['type'] ?? '',
      id: json['property']['id'],
      clientName: json['client']['name'] ?? '',
      leadScoring: '56',
      message: json['message'] ?? '',
      location: json['property']['location'] ?? '',
      simpleDescription: json['property']['fullDescription'] ?? '',
    );
  }
}
