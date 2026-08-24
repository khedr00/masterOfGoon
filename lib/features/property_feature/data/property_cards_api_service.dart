import 'package:dio/dio.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/property_cards_query.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';

class PropertyCardsPage {
  const PropertyCardsPage({
    required this.items,
    this.nextCursor,
    required this.hasNext,
  });
  final List<PropertyCardModel> items;
  final String? nextCursor;
  final bool hasNext;
}

class PropertyCardsApiService {
  PropertyCardsApiService({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: base));
  final Dio _dio;
  Future<PropertyCardsPage> getProperties(
    PropertyCardsQuery query, {
    CancelToken? cancelToken,
  }) async {
    final path = query.hasActiveSearch
        ? 'api/v1/properties/search'
        : 'api/v1/properties';
    final response = await _dio.get(
      path,
      queryParameters: PropertyCardsQueryBuilder.build(query),
      cancelToken: cancelToken,
    );
    if (response.data is! Map) {
      throw const FormatException('Invalid properties response');
    }
    final body = Map<String, dynamic>.from(response.data as Map);
    final data = body['data'];
    if (data is! List) throw const FormatException('Invalid properties data');
    final metadata = _metadata(body);
    final cursor = _string(
      metadata['nextCursor'] ??
          metadata['next_cursor'] ??
          body['nextCursor'] ??
          body['next_cursor'],
    );
    final hasNextValue =
        metadata['hasNext'] ??
        metadata['has_next'] ??
        body['hasNext'] ??
        body['has_next'];
    final items = data
        .whereType<Map>()
        .map(
          (item) => PropertyCardModel.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
    // This API accepts the final property id as `cursor`, but does not return
    // pagination metadata. A full page therefore means there may be another.
    final nextCursor = cursor.isNotEmpty
        ? cursor
        : items.length == query.limit && items.last.id.isNotEmpty
        ? items.last.id
        : null;
    return PropertyCardsPage(
      items: items,
      nextCursor: nextCursor,
      hasNext: hasNextValue is bool ? hasNextValue : nextCursor != null,
    );
  }

  Map<String, dynamic> _metadata(Map<String, dynamic> body) {
    final value = body['pagination'] ?? body['meta'] ?? body['metadata'];
    return value is Map ? Map<String, dynamic>.from(value) : const {};
  }

  String _string(Object? value) => value?.toString().trim() ?? '';
}
