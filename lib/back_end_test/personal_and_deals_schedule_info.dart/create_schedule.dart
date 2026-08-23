import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<String> createSchedule({
  required DioClient dioClient,
  required String type,
  required String date,
  required String title,
  required String description,
  CancelToken? cancelToken,
  String? saleLeaseDealId,
  String? buyRentDealId,
}) async {
  Map<String, dynamic> data;
  if (saleLeaseDealId != null) {
    data = {
      "type": type,
      "date": date,
      "title": title,
      "description": description,
      "saleLeaseDealId": saleLeaseDealId,
    };
  } else if (buyRentDealId != null) {
    data = {
      "type": type,
      "date": date,
      "title": title,
      "description": description,
      "buyRentDealId": buyRentDealId,
    };
  } else {
    data = {
      "type": type,
      "date": date,
      "title": title,
      "description": description,
    };
  }
  try {
    final response = await dioClient.dio.post(
      '${base}api/v1/schedules',
      data: data,
    );
    return response.data['status'];
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error createSchedule');
  } catch (e) {
    throw Exception(e);
  }
}
