import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<String> getLastMeeting({
  required String dealId,
  CancelToken? cancelToken,
  required UserAuthInfo userAuthInfo,
}) async {
  DioClient dioClient = DioClient(userAuthInfo: userAuthInfo);

  try {
    final response = await dioClient.dio.get(
      '${base}api/v1/deals/$dealId/schedules',
      cancelToken: cancelToken,
    );

    List<dynamic> schedules = response.data['data'];

    // 1. فقط الـ MEETING
    final meetings = schedules
        .where((item) => item['title'] == 'MEETING')
        .toList();

    // ما في Meetings
    if (meetings.isEmpty) {
      return 'rejected';
    }

    // 2. ترتيب حسب createdAt من الأحدث للأقدم
    meetings.sort((a, b) {
      final dateA = DateTime.parse(a['createdAt']);
      final dateB = DateTime.parse(b['createdAt']);

      return dateB.compareTo(dateA);
    });

    // 3. أحدث Meeting
    final lastMeeting = meetings.first;

    // 4. تحديد الـ status
    if (lastMeeting['rejectOn'] != null) {
      // print('rejected');
      return 'rejected';
    }

    if (lastMeeting['acceptOn'] != null) {
      // print('accepted');
      return 'accepted';
    }
    // print('pending');
    return 'pending';
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error get Last Meeting');
  } catch (e) {
    throw Exception(e);
  }
}
