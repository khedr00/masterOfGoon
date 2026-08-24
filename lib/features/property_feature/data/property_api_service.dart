import 'package:dio/dio.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/models/property_api_model.dart';

class PropertyApiService {
  PropertyApiService({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: base));
  final Dio _dio;

  Future<PropertyApiModel> getPropertyById(
    String propertyId, {
    CancelToken? cancelToken,
  }) async {
    if (propertyId.trim().isEmpty) {
      throw ArgumentError.value(propertyId, 'propertyId');
    }
    final response = await _dio.get(
      'api/v1/properties/${propertyId.trim()}',
      cancelToken: cancelToken,
    );
    final body = response.data;
    final data = body is Map<String, dynamic> && body['data'] is Map
        ? body['data'] as Map
        : body;
    if (data is! Map) throw const FormatException('Invalid property response');
    return PropertyApiModel.fromJson(Map<String, dynamic>.from(data));
  }
}
