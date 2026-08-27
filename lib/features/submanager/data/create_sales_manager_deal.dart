import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';

Future<void> createBuyRentDeal({
  required DioClient dioClient,
  required String propertyId,
  required String clientId,
  required String employeeId,
  required String dealType,
  CancelToken? cancelToken,
}) async {
  try {
    await dioClient.dio.post(
      'api/v1/deals/buyRentDeal',
      cancelToken: cancelToken,
      data: {
        'propertyId': propertyId,
        'clientId': clientId,
        'employeeId': employeeId,
        'dealType': dealType,
      },
    );
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) throw Exception('Request cancelled');
    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }
    throw Exception('Connection Error createBuyRentDeal');
  }
}

Future<void> createSaleLeaseDeal({
  required DioClient dioClient,
  required String propertyId,
  required String clientId,
  required String employeeId,
  required String dealType,
  required num maxPhasedPrice,
  required num minListingPrice,
  required num maxListingPrice,
  required num profitMargin,
  int? rentalPeriod,
  CancelToken? cancelToken,
}) async {
  try {
    await dioClient.dio.post(
      'api/v1/deals/saleLeaseDeal',
      cancelToken: cancelToken,
      data: {
        'maxPhasedPrice': maxPhasedPrice,
        'minListingPrice': minListingPrice,
        'maxListingPrice': maxListingPrice,
        'profitMargin': profitMargin,
        'propertyId': propertyId,
        'clientId': clientId,
        'employeeId': employeeId,
        'dealType': dealType,
        'rentalPeriod': ?rentalPeriod,
      },
    );
  } on DioException catch (e) {
    if (CancelToken.isCancel(e)) throw Exception('Request cancelled');
    if (e.response != null) {
      throw Exception(e.response?.data['message'] ?? 'Server Error');
    }
    throw Exception('Connection Error createSaleLeaseDeal');
  }
}
