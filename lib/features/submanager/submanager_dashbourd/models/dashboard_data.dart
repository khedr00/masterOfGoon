class DashboardData {
  const DashboardData({
    required this.properties,
    required this.deals,
    required this.employees,
  });

  final PropertyDashboardData properties;
  final DealDashboardData deals;
  final EmployeeDashboardData employees;

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(json['data'] as Map? ?? const {});
    return DashboardData(
      properties: PropertyDashboardData.fromJson(
        Map<String, dynamic>.from(data['properties'] as Map? ?? const {}),
      ),
      deals: DealDashboardData.fromJson(
        Map<String, dynamic>.from(data['deals'] as Map? ?? const {}),
      ),
      employees: EmployeeDashboardData.fromJson(
        Map<String, dynamic>.from(data['employees'] as Map? ?? const {}),
      ),
    );
  }
}

class PropertyDashboardData {
  const PropertyDashboardData({
    required this.total,
    required this.available,
    required this.forSale,
    required this.forLease,
    required this.byType,
    required this.byCity,
    required this.byTypeAndCity,
  });

  final int total;
  final int available;
  final int forSale;
  final int forLease;
  final List<DashboardBreakdown> byType;
  final List<DashboardBreakdown> byCity;
  final List<DashboardBreakdown> byTypeAndCity;

  factory PropertyDashboardData.fromJson(Map<String, dynamic> json) =>
      PropertyDashboardData(
        total: _asInt(json['total']),
        available: _asInt(json['available']),
        forSale: _asInt(json['forSale']),
        forLease: _asInt(json['forLease']),
        byType: _breakdowns(json['byType']),
        byCity: _breakdowns(json['byCity']),
        byTypeAndCity: _breakdowns(json['byTypeAndCity']),
      );
}

class DealDashboardData {
  const DealDashboardData({
    required this.total,
    required this.open,
    required this.successful,
    required this.failed,
    required this.successRate,
    required this.byCity,
    required this.byPropertyType,
    required this.byCityAndPropertyType,
    required this.byDealType,
  });

  final int total;
  final int open;
  final int successful;
  final int failed;
  final double successRate;
  final List<DashboardBreakdown> byCity;
  final List<DashboardBreakdown> byPropertyType;
  final List<DashboardBreakdown> byCityAndPropertyType;
  final List<DashboardBreakdown> byDealType;

  factory DealDashboardData.fromJson(Map<String, dynamic> json) =>
      DealDashboardData(
        total: _asInt(json['total']),
        open: _asInt(json['open']),
        successful: _asInt(json['successful']),
        failed: _asInt(json['failed']),
        successRate: _asDouble(json['successRate']),
        byCity: _breakdowns(json['byCity']),
        byPropertyType: _breakdowns(json['byPropertyType']),
        byCityAndPropertyType: _breakdowns(json['byCityAndPropertyType']),
        byDealType: _breakdowns(json['byDealType']),
      );
}

class EmployeeDashboardData {
  const EmployeeDashboardData({
    required this.total,
    required this.buy,
    required this.sales,
    required this.rentLease,
    required this.inspectors,
  });

  final int total;
  final int buy;
  final int sales;
  final int rentLease;
  final int inspectors;

  factory EmployeeDashboardData.fromJson(Map<String, dynamic> json) =>
      EmployeeDashboardData(
        total: _asInt(json['total']),
        buy: _asInt(json['buy']),
        sales: _asInt(json['sales']),
        rentLease: _asInt(json['rentLease']),
        inspectors: _asInt(json['inspectors']),
      );
}

class DashboardBreakdown {
  const DashboardBreakdown({this.type, this.city, this.dealType, required this.count});

  final String? type;
  final String? city;
  final String? dealType;
  final int count;

  factory DashboardBreakdown.fromJson(Map<String, dynamic> json) =>
      DashboardBreakdown(
        type: _label(json['type'] ?? json['propertyType']),
        city: _label(json['city'] ?? json['cityName'] ?? json['region']),
        dealType: _label(json['dealType'] ?? json['type']),
        count: _asInt(json['count'] ?? json['_count'] ?? json['total']),
      );
}

int _asInt(dynamic value) => value is num ? value.toInt() : int.tryParse('$value') ?? 0;
double _asDouble(dynamic value) => value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
List<DashboardBreakdown> _breakdowns(dynamic value) => (value as List? ?? const [])
    .whereType<Map>()
    .map((item) => DashboardBreakdown.fromJson(Map<String, dynamic>.from(item)))
    .toList();

String? _label(dynamic value) {
  if (value == null) return null;
  if (value is Map) {
    final map = Map<String, dynamic>.from(value);
    return (map['name'] ?? map['title'] ?? map['city'] ?? map['type'])
        ?.toString();
  }
  return value.toString();
}
