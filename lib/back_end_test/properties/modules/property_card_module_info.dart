class PropertyCardModuleInfo {
  PropertyCardModuleInfo({
    required this.photoUrl,
    required this.propertyType,
    required this.nameCode,
    required this.numberOfRooms,
    required this.sqft,
    required this.leastSellPrice,
    required this.simplePropertyDescription,
    required this.address,
    required this.avaliableInternet,
    required this.isAvalable,
  });
  final String photoUrl;
  final String propertyType;
  final String nameCode;
  final int numberOfRooms;
  final int sqft;
  final int leastSellPrice;
  final String simplePropertyDescription;
  final String address;
  final bool avaliableInternet;
  final bool isAvalable;
}
