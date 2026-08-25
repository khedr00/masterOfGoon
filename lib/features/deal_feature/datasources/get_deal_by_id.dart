import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/deal_feature/models/deal_model.dart';

Future<DealModel> getDealById({
  required DioClient dioClient,
  CancelToken? cancelToken,
  required String dealId,
}) async {
  try {
    final dynamic response;

    response = await dioClient.dio.get('${base}api/v1/deals/$dealId');
    // print('${response.data}');
    // print(response.data['data']);

    return DealModel.fromJson(response.data['data']);
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
