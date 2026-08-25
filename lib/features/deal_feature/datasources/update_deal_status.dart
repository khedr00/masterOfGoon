import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';

Future<String> failDeal({
  required DioClient dioClient,
  required String dealId,
}) async {
  return _updateDeal(
    request: () => dioClient.dio.patch('api/v1/deals/$dealId/fail'),
  );
}

Future<String> completeDeal({
  required DioClient dioClient,
  required String dealId,
  required Map<String, num> data,
}) async {
  return _updateDeal(
    request: () => dioClient.dio.patch(
      'api/v1/deals/$dealId/complete',
      data: data,
    ),
  );
}

Future<String> _updateDeal({required Future<Response> Function() request}) async {
  try {
    final response = await request();
    return response.data['message']?.toString() ?? 'Deal updated successfully';
  } on DioException catch (error) {
    throw Exception(
      error.response?.data is Map
          ? error.response?.data['message'] ?? 'Server Error'
          : 'Server Error',
    );
  } catch (error) {
    throw Exception(error.toString());
  }
}
