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

  factory DealCardInfo.fromJson(Map<String, dynamic> json) {
    final client = json['client'] as Map<String, dynamic>? ?? {};
    final property = json['property'] as Map<String, dynamic>? ?? {};

    return DealCardInfo(
      id: json['id']?.toString() ?? '',

      // Not available in API
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',

      propertyType: property['type']?.toString() ?? '',

      // sale / lease -> maxPhasedPrice
      // buy / rent -> actualPrice
      propertyPrice:
          (json['maxPhasedPrice'] ?? property['actualPrice'] ?? 0) is num
          ? ((json['maxPhasedPrice'] ?? property['actualPrice'] ?? 0) as num)
                .toInt()
          : 0,

      propertySimpleDescription: property['fullDescription']?.toString() ?? '',

      // Using location as the property address
      propertyAddress: property['location']?.toString() ?? '',

      clientName: client['name']?.toString() ?? '',

      clientPhoto:
          client['photo']?.toString() ?? 'assets/images/profilePhoto-icon.png',

      // Not available in API
      title: '',

      dealStage: json['dealStatus']?.toString() ?? '',

      // Not available in API
      successProbability: 0,

      startingDate: json['createdAt']?.toString().substring(0, 10) ?? '',

      // Not available in API
      clientId: 0,

      // Not available in API
      propertyId: 0,
    );
  }
}
