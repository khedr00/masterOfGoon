import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/models/dashboard_data.dart';

class DashboardRepository {
  DashboardRepository(this._userAuthInfo);

  final UserAuthInfo _userAuthInfo;

  Future<DashboardData> getDashboard({DateTime? from, DateTime? to}) async {
    final response = await DioClient(userAuthInfo: _userAuthInfo).dio.get(
      '/api/v1/dashboard',
      queryParameters: {
        if (from != null) 'from': _startOfDay(from),
        if (to != null) 'to': _endOfDay(to),
      },
    );
    return DashboardData.fromJson(Map<String, dynamic>.from(response.data as Map));
  }

  static String _startOfDay(DateTime date) =>
      '${_datePart(date)}T00:00:00Z';
  static String _endOfDay(DateTime date) => '${_datePart(date)}T23:59:59Z';
  static String _datePart(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
