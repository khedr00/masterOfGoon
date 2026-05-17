import 'package:untitled1/back_end_test/login/user_auth_info.dart';

Future<UserAuthInfo> getUserAuthInfo({
  required String name,
  required String password,
}) async {
  await Future.delayed(const Duration(seconds: 2));
  Map<String, dynamic> temp = {};
  if (name == 'khedr') {
    temp = {'id': 1, 'role': 'sales employee'};
  } else if (name == 'issa') {
    temp = {'id': 2, 'role': 'Rent employee'};
  } else if (name == 'zain') {
    temp = {'id': 3, 'role': 'purchase employee'};
  } else if (name == 'manager') {
    temp = {'id': 4, 'role': 'submanager'};
  } else if (name == 'support') {
    temp = {'id': 5, 'role': 'support'};
  } else if (name == 'general') {
    temp = {'id': 6, 'role': 'general'};
  } else {
    temp = {'id': 1, 'role': 'sales employee'};
  }

  return UserAuthInfo(
    id: temp['id'],
    role: temp['role'],
    accessToken: '',
    refreshToken: '',
  );
}
