class DealRequestCardInfo {
  DealRequestCardInfo({
    required this.referenceCode,
    required this.listedPrice,
    required this.type,
    required this.clientName,
    required this.clientId,
    required this.clientPhoto,
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
  final String clientId;
  final String clientPhoto;
  final String leadScoring;
  final String message;
  final String location;
  final String simpleDescription;
  final String id;

  factory DealRequestCardInfo.fromJson(Map<String, dynamic> json) {
    final property = Map<String, dynamic>.from(json['property'] as Map? ?? {});
    final client = Map<String, dynamic>.from(json['client'] as Map? ?? {});

    return DealRequestCardInfo(
      referenceCode: property['referenceCode']?.toString() ?? '',
      listedPrice: property['listedPrice']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      id: property['id']?.toString() ?? '',
      clientName:
          client['name']?.toString() ?? client['fullName']?.toString() ?? '',
      clientId: client['id']?.toString() ?? '',
      clientPhoto: client['photo']?.toString() ?? '',
      leadScoring: '56',
      message: json['message']?.toString() ?? '',
      location: property['location']?.toString() ?? '',
      simpleDescription: property['fullDescription']?.toString() ?? '',
    );
  }
}
