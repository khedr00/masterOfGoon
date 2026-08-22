import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<String> createComplaint({
  required DioClient dioClient,
  CancelToken? cancelToken,
  required String complaintTypeId,
  required String issueMessage,
}) async {
  try {
    final dynamic response;

    response = await dioClient.dio.post(
      '${base}api/v1/complaints',
      data: {"issueMessage": issueMessage, "complaintTypeId": complaintTypeId},
    );

    if (response.data['status'] == 'success') {
      return 'Complaint created successfully';
    } else {
      return 'there was a problem in creating the complaint , please try again';
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
