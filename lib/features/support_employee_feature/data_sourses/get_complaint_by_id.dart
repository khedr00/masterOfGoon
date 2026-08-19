import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/get_employee_info/employee_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<EmployeeInfo> getComplaintById({
  required DioClient dioClient,
  CancelToken? cancelToken,
  String? employeeId,
}) async {
  try {
    final dynamic response;

    response = await dioClient.dio.get('${base}api/v1/complaints/$employeeId');

    return EmployeeInfo(
      employeeName: response.data['data']['employee']['fullName'],
      employeeType: response.data['data']['employee']['role'],
      employeePhoto: response.data['data']['employee']['photo'],
      employeeEmail: response.data['data']['email'],
      employeePhoneNumber: response.data['data']['employee']['phone'],
      employeeLocation: response.data['data']['employee']['location'],
      productivity: response.data['data']['employee']['productivity'],
      avgResponseTime: response.data['data']['employee']['averageResponseTime'],
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
