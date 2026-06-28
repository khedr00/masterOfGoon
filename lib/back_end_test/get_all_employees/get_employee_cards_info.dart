import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/get_all_employees/employee_card_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<List<EmployeeCardInfo>> getEmployeeCardsInfo({
  required DioClient dioClient,
  CancelToken? cancelToken,
}) async {
  try {
    final response = await dioClient.dio.get('${base}api/v1/employees');
    final data = response.data['data'];
    List<EmployeeCardInfo> temp = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i]['role'] == 'SALES' ||
          data[i]['role'] == 'RENTAL' ||
          data[i]['role'] == 'LEASE' ||
          data[i]['role'] == 'PURCHASING') {
        temp.add(EmployeeCardInfo.fromJson(data[i]));
      }
    }
    return temp;
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
