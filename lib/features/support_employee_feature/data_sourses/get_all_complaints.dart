import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee_feature/models/complaint_card_info.dart';

Future<List<ComplaintCardInfo>> getAllComplaints({
  required DioClient dioClient,
  CancelToken? cancelToken,
}) async {
  try {
    final response = await dioClient.dio.get('${base}api/v1/complaints');
    final data = response.data['data'];
    List<ComplaintCardInfo> temp = [];
    for (int i = 0; i < data.length; i++) {
      temp.add(ComplaintCardInfo.fromJson(data[i]));
    }
    return temp;
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error get all complains');
  } catch (e) {
    throw Exception(e);
  }
}
