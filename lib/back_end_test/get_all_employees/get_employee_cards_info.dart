import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/get_all_employees/employee_card_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';

Future<List<EmployeeCardInfo>> getEmployeeCardsInfo({
  required DioClient dioClient,
  CancelToken? cancelToken,
}) async {
  try {
    // final response = await dioClient.dio.get('${base}api/v1/auth/getMe');
    return [
      EmployeeCardInfo(
        employeeId: '',
        employeeName: 'employeeName',
        employeePhoto: 'employeePhoto',
        employeeType: 'employeeType',
        employeeLocation: 'employeeLocation',
        productivity: 'productivity',
      ),
    ];
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
