import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';

class DioClient {
  late Dio dio;

  final UserAuthInfo userAuthInfo;

  DioClient({required this.userAuthInfo}) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000/api/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] =
              'Bearer ${userAuthInfo.accessToken}';

          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              final response = await dio.post(
                'refresh-token',
                data: {'refresh_token': userAuthInfo.refreshToken},
              );

              final newAccessToken = response.data['access_token'];

              userAuthInfo.accessToken = newAccessToken;

              error.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              final clonedResponse = await dio.fetch(error.requestOptions);

              return handler.resolve(clonedResponse);
            } catch (e) {
              return handler.reject(error);
            }
          }

          handler.next(error);
        },
      ),
    );
  }
}
