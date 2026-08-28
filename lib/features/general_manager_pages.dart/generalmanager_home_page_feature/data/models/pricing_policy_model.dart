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
      city: _readString(json['city'], 'city'),
      propertyType: _readString(json['propertyType'], 'propertyType'),
      sellProfitMargin: _readDouble(json['sellProfitMargin']),
      rentProfitMargin: _readDouble(json['rentProfitMargin']),
      saleListingMargin: _readDouble(json['saleListingMargin']),
      rentListingMargin: _readDouble(json['rentListingMargin']),
      saleGlobalAdjust: _readDouble(json['saleGlobalAdjust']),
      rentGlobalAdjust: _readDouble(json['rentGlobalAdjust']),
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

  static String _readString(dynamic value, String fieldName) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) {
      throw FormatException('Pricing policy $fieldName is missing');
    }

    return text;
  }

  static double _readDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null) {
        return parsed;
      }
    }

    return 0;
  }
}
