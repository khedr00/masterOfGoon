import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';

Future<String> changeDealEmployee({
  required DioClient dioClient,
  required String dealId,
  required String employeeId,
}) async {
  try {
    final response = await dioClient.dio.patch(
      'api/v1/deals/$dealId/changeEmployee',
      data: {'employeeId': employeeId.trim()},
    );
    return response.data['message']?.toString() ??
        'Employee updated for this deal successfully';
  } on DioException catch (error) {
    throw Exception(
      error.response?.data is Map
          ? error.response?.data['message'] ?? 'Server Error'
          : 'Server Error',
    );
  }
}
