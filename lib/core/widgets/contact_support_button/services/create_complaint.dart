import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/get_employee_info/employee_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<EmployeeInfo> createComplaint({
  required DioClient dioClient,
  CancelToken? cancelToken,
  required String complaintTypeId,
  required String issueMessage,
}) async {
  try {
    final dynamic response;

    response = await dioClient.dio.get('${base}api/v1/complaints');

    return EmployeeInfo(
      employeeName: response.data['data']['fullName'],
      employeeType: response.data['data']['role'],
      employeePhoto: response.data['data']['photo'],
      employeeEmail: response.data['data']['user']['email'],
      employeePhoneNumber: response.data['data']['phone'],
      employeeLocation: response.data['data']['location'],
      productivity: response.data['data']['productivity'],
      avgResponseTime: response.data['data']['averageResponseTime'],
    );
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
