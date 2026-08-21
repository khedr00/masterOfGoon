import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/notification/modules/notification_model.dart';

Future<List<NotificationModel>> getAllNotifications({
  CancelToken? cancelToken,
  required DioClient dioClient,
}) async {
  try {
    final dynamic response;
    response = await dioClient.dio.get(
      '${base}api/v1/notifications/myNotifications',
    );

    List<NotificationModel> result = [];
    for (int i = 0; i < response.data['data'].length; i++) {
      result.add(NotificationModel.fromJson(response.data['data'][i]));
    }

    return result;
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error getAllNotifications');
  } catch (e) {
    throw Exception(e);
  }
}
