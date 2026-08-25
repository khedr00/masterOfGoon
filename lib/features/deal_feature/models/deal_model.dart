class DealModel {
  String? id;
  num? maxPhasedPrice;
  num? minListingPrice;
  num? maxListingPrice;
  num? profitMargin;
  String? dealType;
  String? dealStatus;
  String? propertyId;
  String? clientId;
  String? employeeId;
  int? rentalPeriod;
  String? createdAt;

  // موجودة فقط في BUY / RENT
  num? listedPrice;
  num? actualPrice;

  DealModel({
    this.id,
    this.maxPhasedPrice,
    this.minListingPrice,
    this.maxListingPrice,
    this.profitMargin,
    this.dealType,
    this.dealStatus,
    this.propertyId,
    this.clientId,
    this.employeeId,
    this.rentalPeriod,
    this.createdAt,
    this.listedPrice,
    this.actualPrice,
  });

  DealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maxPhasedPrice = json['maxPhasedPrice'];
    minListingPrice = json['minListingPrice'];
    maxListingPrice = json['maxListingPrice'];
    profitMargin = json['profitMargin'];

    dealType = json['dealType'];
    dealStatus = json['dealStatus'];
    propertyId = json['propertyId'];
    clientId = json['clientId'];
    employeeId = json['employeeId'];
    rentalPeriod = json['rentalPeriod'];
    createdAt = json['createdAt'].substring(0, 10);

    // BUY / RENT
    if (json['property'] != null) {
      listedPrice = json['property']['listedPrice'];
      actualPrice = json['property']['actualPrice'];
    }
  }
}
