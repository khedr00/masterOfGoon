import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/models/pricing_policy_model.dart';

Future<String> updatePricingPolicy({
  required DioClient dioClient,
  required String pricingPolicyId,
  required PricingPolicyModel pricingPolicyModel,
  CancelToken? cancelToken,
}) async {
  try {
    final response = await dioClient.dio.patch(
      '${base}api/v1/properties/pricingPolicies/$pricingPolicyId',
      data: pricingPolicyModel.toUpdateJson(),
      cancelToken: cancelToken,
    );

    final responseData = response.data;
    if (responseData is Map<String, dynamic> &&
        responseData['status'] == 'success') {
      return responseData['message'] as String? ??
          'pricing policy updated successfully';
    }

    return 'there was a problem in updating pricing policies';
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error updatePricingPolicy');
  } catch (e) {
    throw Exception(e);
  }
}
