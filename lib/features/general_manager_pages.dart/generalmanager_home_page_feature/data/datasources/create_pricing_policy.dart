import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/generalmanager_home_page_feature/data/models/pricing_policy_model.dart';

Future<String> createPricingPolicy({
  required DioClient dioClient,
  required PricingPolicyModel pricingPolicyModel,
  CancelToken? cancelToken,
}) async {
  try {
    final dynamic response;
    response = await dioClient.dio.post(
      '${base}api/v1/properties/pricingPolicies',
      data: pricingPolicyModel.toJson(),
    );
    if (response['status'] == 'success') {
      return 'pricing policy created';
    } else {
      return 'there was a problem in creating pricing policies';
    }
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error getMe');
  } catch (e) {
    throw Exception(e);
  }
}
