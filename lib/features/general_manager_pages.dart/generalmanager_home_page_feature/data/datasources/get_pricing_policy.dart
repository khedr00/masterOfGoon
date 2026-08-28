import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/models/pricing_policy_model.dart';

Future<PricingPolicyModel> getPricingPolicy({
  CancelToken? cancelToken,
  required DioClient dioClient,
  required String city,
  required String propertyType,
}) async {
  try {
    final dynamic response;
    response = await dioClient.dio.get(
      '${base}api/v1/properties/pricingPolicies?propertyType=$propertyType&city=$city',
      cancelToken: cancelToken,
    );

    final pricingPolicyJson = _pricingPolicyJsonFromResponse(response.data);
    if (pricingPolicyJson == null) {
      throw Exception('Pricing policy was not found for $city $propertyType');
    }

    PricingPolicyModel result = PricingPolicyModel.fromJson(pricingPolicyJson);

    return result;
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error getPricingPolicy');
  } catch (e) {
    throw Exception(e);
  }
}

Map<String, dynamic>? _pricingPolicyJsonFromResponse(dynamic responseData) {
  if (responseData is! Map) {
    return null;
  }

  final data = responseData['data'];

  if (data is Map) {
    final nestedPolicy = data['pricingPolicy'] ?? data['policy'];
    if (nestedPolicy is Map) {
      return Map<String, dynamic>.from(nestedPolicy);
    }

    return Map<String, dynamic>.from(data);
  }

  if (data is List && data.isNotEmpty && data.first is Map) {
    return Map<String, dynamic>.from(data.first as Map);
  }

  final directPolicy = responseData['pricingPolicy'] ?? responseData['policy'];
  if (directPolicy is Map) {
    return Map<String, dynamic>.from(directPolicy);
  }

  return null;
}
