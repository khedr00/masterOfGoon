class PricingPolicyModel {
  PricingPolicyModel({
    this.id = '',
    required this.city,
    required this.propertyType,
    required this.sellProfitMargin,
    required this.rentProfitMargin,
    required this.saleListingMargin,
    required this.rentListingMargin,
    required this.saleGlobalAdjust,
    required this.rentGlobalAdjust,
  });

  final String id;
  final String city;
  final String propertyType;
  final double sellProfitMargin;
  final double rentProfitMargin;
  final double saleListingMargin;
  final double rentListingMargin;
  final double saleGlobalAdjust;
  final double rentGlobalAdjust;

  factory PricingPolicyModel.fromJson(Map<String, dynamic> json) {
    return PricingPolicyModel(
      id: (json['id'] ?? json['_id'] ?? json['pricingPolicyId'] ?? '')
          .toString(),
      city: json['city'] as String,
      propertyType: json['propertyType'] as String,
      sellProfitMargin: (json['sellProfitMargin'] as num).toDouble(),
      rentProfitMargin: (json['rentProfitMargin'] as num).toDouble(),
      saleListingMargin: (json['saleListingMargin'] as num).toDouble(),
      rentListingMargin: (json['rentListingMargin'] as num).toDouble(),
      saleGlobalAdjust: (json['saleGlobalAdjust'] as num).toDouble(),
      rentGlobalAdjust: (json['rentGlobalAdjust'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'propertyType': propertyType,
      'sellProfitMargin': sellProfitMargin,
      'rentProfitMargin': rentProfitMargin,
      'saleListingMargin': saleListingMargin,
      'rentListingMargin': rentListingMargin,
      'saleGlobalAdjust': saleGlobalAdjust,
      'rentGlobalAdjust': rentGlobalAdjust,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'sellProfitMargin': sellProfitMargin,
      'rentProfitMargin': rentProfitMargin,
      'saleListingMargin': saleListingMargin,
      'rentListingMargin': rentListingMargin,
      'saleGlobalAdjust': saleGlobalAdjust,
      'rentGlobalAdjust': rentGlobalAdjust,
    };
  }
}
