enum PropertyFilterOperator { equals, gte, lte, gt, lt }

class PropertyFilter {
  const PropertyFilter(this.field, this.value, {this.operator = PropertyFilterOperator.equals});
  final String field;
  final String value;
  final PropertyFilterOperator operator;
  String get queryKey => operator == PropertyFilterOperator.equals ? field : '$field[${operator.name}]';
}

class PropertyCardsQuery {
  const PropertyCardsQuery({this.filters = const [], this.searchQuery = '', this.orderBy = const [], this.limit = 10, this.cursor});
  final List<PropertyFilter> filters;
  final String searchQuery;
  final List<String> orderBy;
  final int limit;
  final String? cursor;
  bool get hasActiveFilters => filters.isNotEmpty;
  bool get hasActiveSearch => searchQuery.trim().isNotEmpty;
  PropertyCardsQuery copyWith({List<PropertyFilter>? filters, String? searchQuery, List<String>? orderBy, String? cursor, bool clearCursor = false}) => PropertyCardsQuery(filters: filters ?? this.filters, searchQuery: searchQuery ?? this.searchQuery, orderBy: orderBy ?? this.orderBy, limit: limit, cursor: clearCursor ? null : cursor ?? this.cursor);
}

class PropertyCardsQueryBuilder {
  const PropertyCardsQueryBuilder._();
  static Map<String, dynamic> build(PropertyCardsQuery query) {
    final parameters = <String, dynamic>{'limit': query.limit};
    if (query.hasActiveSearch) parameters['q'] = query.searchQuery.trim();
    if (query.cursor?.trim().isNotEmpty == true) parameters['cursor'] = query.cursor!.trim();
    if (query.orderBy.isNotEmpty) parameters['orderBy'] = query.orderBy.join(',');
    final grouped = <String, List<String>>{};
    for (final filter in query.filters) {
      final field = filter.field.trim();
      final value = filter.value.trim();
      if (field.isNotEmpty && value.isNotEmpty) {
        grouped.putIfAbsent(filter.queryKey, () => <String>[]).add(value);
      }
    }
    // Dio serializes a list as repeated query values, preserving OR selections.
    for (final entry in grouped.entries) {
      parameters[entry.key] = entry.value.length == 1 ? entry.value.single : entry.value;
    }
    return parameters;
  }
}
