// import 'package:dio/dio.dart';
// import 'package:untitled1/back_end_test/deal_requests/deal_request_card_info.dart';

// Future<List<DealRequestCardInfo>> getDealRequestCardsInfo({
//   required String role,
//   required String id,
//   CancelToken? cancelToken,
// }) async {
//   await Future.delayed(const Duration(seconds: 3));
//   List<Map<String, dynamic>> temp = [
//     {
//       'id': 0,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'buy',
//       'startingDate': '1/7/2025',
//       'clientMessage': 'i would like to buy this',
//     },
//     {
//       'id': 1,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'buy',
//       'startingDate': '1/7/2025',
//     },
//     {
//       'id': 2,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'buy',
//       'startingDate': '2/7/2025',
//       'clientMessage': 'i would like to buy this',
//     },
//     {
//       'id': 3,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'buy',
//       'startingDate': '3/7/2025',
//       'clientMessage': 'i would like to buy this',
//     },
//     {
//       'id': 4,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'leasing',
//       'startingDate': '4/7/2025',
//       'clientMessage': 'i would like to buy this',
//     },
//     {
//       'id': 5,
//       'propertyId': 1,
//       'clientId': 1,
//       'requestType': 'rent',
//       'startingDate': '2/7/2025',
//       'clientMessage': 'i would like to buy this',
//     },
//   ];

//   List<DealRequestCardInfo> dealRequestList = [];
//   for (int i = 0; i < temp.length; i++) {
//     dealRequestList.add(
//       DealRequestCardInfo(
//         id: temp[i]['id'],
//         propertyId: temp[i]['propertyId'],
//         clientId: temp[i]['clientId'],
//         requestType: temp[i]['requestType'],
//         startingDate: temp[i]['startingDate'],
//         clientMessage: temp[i]['clientMessage'],
//       ),
//     );
//   }
//   return dealRequestList;
// }
