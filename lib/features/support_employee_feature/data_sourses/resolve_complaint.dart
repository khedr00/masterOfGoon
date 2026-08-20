import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<String> resolveComplaint({
  required DioClient dioClient,
  CancelToken? cancelToken,
  required String complaintId,
}) async {
  try {
    final dynamic response;

    response = await dioClient.dio.patch(
      '${base}api/v1/complaints/$complaintId/resolve',
    );

    return response.data['status'];
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
