import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/sales_manager_requests/sales_manager_request_model.dart';
import 'package:untitled1/core/widgets/constants.dart';

Future<List<DealRequestCardInfo>> getAllRequests({
  required DioClient dioClient,
  CancelToken? cancelToken,
}) async {
  try {
    final response = await dioClient.dio.get('${base}api/v1/requests');
    print(response);
    final data = response.data['data'];
    List<DealRequestCardInfo> temp = [];
    for (int i = 0; i < data.length; i++) {
      temp.add(DealRequestCardInfo.fromJson(data[i]));
    }
    return temp;
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) {
      throw Exception('Request cancelled');
    }

    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }

    throw Exception('Connection Error getMe');
  } catch (e) {
    throw Exception(e);
  }
}
