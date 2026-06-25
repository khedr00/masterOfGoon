import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<UserAuthInfo> getUserAuthInfo({
  required String email,
  required String password,
}) async {
  try {
    Dio dio = Dio();
    final response = await dio.post(
      '${base}api/v1/auth/login',
      data: {'email': email, 'password': password},
    );
    return UserAuthInfo.fromJson(response.data, '');
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error بشششششش');
  } catch (e) {
    throw Exception(e);
  }
}
