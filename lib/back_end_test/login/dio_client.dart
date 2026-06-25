import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DioClient {
  late Dio dio;

  final UserAuthInfo userAuthInfo;

  DioClient({required this.userAuthInfo}) {
    dio = Dio(
      BaseOptions(
        baseUrl: base,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (userAuthInfo.accessToken.isNotEmpty) {
            options.headers['Authorization'] =
                'Bearer ${userAuthInfo.accessToken}';
          }
          handler.next(options);
        },

        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            if (error.requestOptions.path.contains('refreshToken')) {
              return handler.next(error);
            }

            try {
              final refreshResponse = await dio.post(
                'api/v1/auth/refreshToken',
              );

              final newAccessToken = refreshResponse.data['token'];

              userAuthInfo.accessToken = newAccessToken;

              error.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';

              final retryResponse = await dio.fetch(error.requestOptions);

              return handler.resolve(retryResponse);
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
