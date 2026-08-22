import 'package:dio/dio.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/contact_support_button/models/complaint_type_model.dart';

Future<List<ComplaintTypeModel>> getAllComplaintTypes() async {
  try {
    List<ComplaintTypeModel> result = [];
    Dio dio = Dio();
    final response = await dio.get('${base}api/v1/complaints/complaintTypes');
    for (int i = 0; i < response.data['data'].length; i++) {
      result.add(ComplaintTypeModel.fromJson(response.data['data'][i]));
    }
    return result;
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
