import 'package:untitled1/back_end_test/login/user_auth_info.dart';

Future<UserAuthInfo> getUserAuthInfo({
  required String email,
  required String password,
}) async {
  // try {
  // Dio dio = Dio();

  // final response = await dio.post(
  //   'https://dummyjson.com/auth/login',
  //   data: {'email': email, 'password': password},
  // );
  Map<String, dynamic> temp = {};
  if (email == 'khedr') {
    temp = {
      'id': 1,
      'role': 'SALES',
      'accessToken': 'adsc',
      'refreshToken': 'asdca',
    };
  } else if (email == 'issa') {
    temp = {
      'id': 2,
      'role': 'RENTAL',
      'accessToken': 'adscad',
      'refreshToken': 'casdc',
    };
  } else if (email == 'zain') {
    temp = {
      'id': 3,
      'role': 'PURCHASING',
      'accessToken': 'acsdc',
      'refreshToken': 'casdc',
    };
  } else if (email == 'manager') {
    temp = {
      'id': 4,
      'role': 'SALES_MANAGER',
      'accessToken': 'acdc',
      'refreshToken': 'acsdc',
    };
  } else if (email == 'support') {
    temp = {
      'id': 5,
      'role': 'support',
      'accessToken': 'cdsac',
      'refreshToken': 'dca',
    };
  } else if (email == 'general') {
    temp = {
      'id': 6,
      'role': 'GENERAL_MANAGER',
      'accessToken': 'dcd',
      'refreshToken': 'cdsad',
    };
  } else {
    temp = {
      'id': 1,
      'role': 'SALES',
      'accessToken': 'gg',
      'refreshToken': 'gg',
    };
  }

  // return UserAuthInfo.fromJson(temp);
  return UserAuthInfo(
    id: temp['id'],
    role: temp['role'],
    accessToken: temp['accessToken'],
    refreshToken: temp['refreshToken'],
  );
} 
  // on DioException catch (e) {
  //   if (CancelToken.isCancel(e)) {
  //     throw Exception('Request cancelled');
  //   }

  //   if (e.response != null) {
  //     throw Exception(e.response?.data['message'] ?? 'Server Error');
  //   }

  //   throw Exception('Connection Error');
  // } catch (e) {
  //   throw Exception(e);
  // }
// }
