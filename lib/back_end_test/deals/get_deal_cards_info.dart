import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/deal_card_info.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/rent_and_lease_deal_card_info.dart';

Future<List<DealCardInfo>> getDealCardsInfo({
  required String role,
  required int id,
  CancelToken? cancelToken,
}) async {
  await Future.delayed(const Duration(seconds: 3));
  List<Map<String, dynamic>> temp = [
    {
      'id': 1,
      'propertyId': 1,
      'clientId': 1,
      'title': 'Request to Buy Property – Homs City',
      'dealStage': 'negotiation',
      'successProbability': 23,
      'startingDate': '2/7/2025',
    },
    {
      'id': 2,
      'propertyId': 2,
      'clientId': 2,
      'title': 'Request to Buy Property – Homs City 2',
      'dealStage': 'negotiation',
      'successProbability': 24,
      'startingDate': '3/7/2025',
    },
    {
      'id': 3,
      'propertyId': 3,
      'clientId': 3,
      'title': 'Request to Buy Property – Homs City 3',
      'dealStage': 'negotiation',
      'successProbability': 25,
      'startingDate': '4/7/2025',
    },
    {
      'id': 4,
      'propertyId': 4,
      'clientId': 4,
      'title': 'Request to Buy Property – Homs City 4',
      'dealStage': 'negotiation',
      'successProbability': 26,
      'startingDate': '5/7/2025',
    },
    {
      'id': 5,
      'propertyId': 5,
      'clientId': 5,
      'title': 'Request to Buy Property – Homs City 5',
      'dealStage': 'negotiation',
      'successProbability': 27,
      'startingDate': '6/7/2025',
    },
    {
      'id': 6,
      'propertyId': 6,
      'clientId': 6,
      'title': 'Request to Buy Property – Homs City 6',
      'dealStage': 'negotiation',
      'successProbability': 28,
      'startingDate': '7/7/2025',
    },
  ];

  List<DealCardInfo> dealList = [];
  for (int i = 0; i < temp.length; i++) {
    if (temp[i].containsKey('rentalPeriod')) {
      dealList.add(
        RentAndLeaseDealCardInfo(
          id: temp[i]['id'],
          propertyId: temp[i]['propertyId'],
          clientId: temp[i]['clientId'],
          title: temp[i]['title'],
          dealStage: temp[i]['dealStage'],
          successProbability: temp[i]['successProbability'],
          startingDate: temp[i]['startingDate'],
          propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
          propertyType: 'hall',
          propertyPrice: 30003,
          propertySimpleDescription:
              'Furnished Apartment with pool and 2 balconies 3',
          propertyAddress: 'homs_shien3',
          clientPhoto: 'assets/images/profilePhoto-icon.png',
          clientName: 'aliAhmad2',
          rentalPeriod: 4,
        ),
      );
    } else {
      dealList.add(
        DealCardInfo(
          id: temp[i]['id'],
          propertyId: temp[i]['propertyId'],
          clientId: temp[i]['clientId'],
          title: temp[i]['title'],
          dealStage: temp[i]['dealStage'],
          successProbability: temp[i]['successProbability'],
          startingDate: temp[i]['startingDate'],
          propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
          propertyType: 'hall',
          propertyPrice: 30003,
          propertySimpleDescription:
              'Furnished Apartment with pool and 2 balconies 3',
          propertyAddress: 'homs_shien3',
          clientPhoto: 'assets/images/profilePhoto-icon.png',
          clientName: 'aliAhmad2',
        ),
      );
    }
  }
  return dealList;
}
