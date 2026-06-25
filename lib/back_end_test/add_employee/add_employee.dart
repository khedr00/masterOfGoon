import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<String> addEmployee({
  required DioClient dioClient,
  CancelToken? cancelToken,
  required String name,
  required String role,
  required String fullName,
  required String location,
  required String phone,
  required int salary,
  required String email,
  required String password,
}) async {
  try {
    final response = await dioClient.dio.post(
      '${base}api/v1/employees',
      data: {
        "name": name,
        "role": role,
        "fullName": fullName,
        "location": location,
        "phone": phone,
        "salary": salary,
        "email": email,
        "password": password,
      },
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
