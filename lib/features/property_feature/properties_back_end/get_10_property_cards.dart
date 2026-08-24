import 'package:dio/dio.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/appartment_card_module_info.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/hall_card_module_info.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/house_card_module_info.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/prpoperty_card_info/property_card_model.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_module_info.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/store_card_module_info.dart';
// import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/villa_card_module_info.dart';
import 'package:untitled1/features/property_feature/data/property_cards_api_service.dart';
import 'package:untitled1/features/property_feature/data/property_cards_query.dart';

// Future<List<PropertyCardModuleInfo>> fillPropertyCardModulesInfo(
//   List<Map<String, dynamic>> temp,
// ) async {
//   List<PropertyCardModuleInfo> temp2 = [];
//   for (int i = 0; i < temp.length; i++) {
//     switch (temp[i]['propertyType']) {
//       case 'house':
//         temp2.add(
//           HouseCardModuleInfo(
//             photoUrl: temp[i]['imageUrl'],
//             propertyType: temp[i]['propertyType'],
//             nameCode: temp[i]['nameCode'],
//             numberOfRooms: temp[i]['numberOfRooms'],
//             sqft: temp[i]['sqft'],
//             leastSellPrice: temp[i]['leastSellPrice'],
//             simplePropertyDescription: temp[i]['simplePropertyDescription'],
//             address: temp[i]['address'],
//             avaliableInternet: temp[i]['avaliableInternet'],
//             isAvalable: temp[i]['isAvalable'],
//             numberOfFloors: temp[i]['numberOfFloors'],
//             id: temp[i]['id'],
//           ),
//         );
//         break;
//       case 'villa':
//         temp2.add(
//           VillaCardModuleInfo(
//             photoUrl: temp[i]['imageUrl'],
//             propertyType: temp[i]['propertyType'],
//             nameCode: temp[i]['nameCode'],
//             numberOfRooms: temp[i]['numberOfRooms'],
//             sqft: temp[i]['sqft'],
//             leastSellPrice: temp[i]['leastSellPrice'],
//             simplePropertyDescription: temp[i]['simplePropertyDescription'],
//             address: temp[i]['address'],
//             avaliableInternet: temp[i]['avaliableInternet'],
//             isAvalable: temp[i]['isAvalable'],
//             garden: temp[i]['garden'],
//             id: temp[i]['id'],
//           ),
//         );
//         break;
//       case 'apartment':
//         temp2.add(
//           ApartmentCardModuleInfo(
//             photoUrl: temp[i]['imageUrl'],
//             propertyType: temp[i]['propertyType'],
//             nameCode: temp[i]['nameCode'],
//             numberOfRooms: temp[i]['numberOfRooms'],
//             sqft: temp[i]['sqft'],
//             leastSellPrice: temp[i]['leastSellPrice'],
//             simplePropertyDescription: temp[i]['simplePropertyDescription'],
//             address: temp[i]['address'],
//             avaliableInternet: temp[i]['avaliableInternet'],
//             isAvalable: temp[i]['isAvalable'],
//             elevator: temp[i]['elevator'],
//             id: temp[i]['id'],
//           ),
//         );
//         break;
//       case 'store':
//         temp2.add(
//           StoreCardModuleInfo(
//             photoUrl: temp[i]['imageUrl'],
//             propertyType: temp[i]['propertyType'],
//             nameCode: temp[i]['nameCode'],
//             numberOfRooms: temp[i]['numberOfRooms'],
//             sqft: temp[i]['sqft'],
//             leastSellPrice: temp[i]['leastSellPrice'],
//             simplePropertyDescription: temp[i]['simplePropertyDescription'],
//             address: temp[i]['address'],
//             avaliableInternet: temp[i]['avaliableInternet'],
//             interface: temp[i]['interface'],
//             isAvalable: temp[i]['isAvalable'],
//             id: temp[i]['id'],
//           ),
//         );
//         break;
//       case 'hall':
//         temp2.add(
//           HallCardModuleInfo(
//             photoUrl: temp[i]['imageUrl'],
//             propertyType: temp[i]['propertyType'],
//             nameCode: temp[i]['nameCode'],
//             numberOfRooms: temp[i]['numberOfRooms'],
//             sqft: temp[i]['sqft'],
//             leastSellPrice: temp[i]['leastSellPrice'],
//             simplePropertyDescription: temp[i]['simplePropertyDescription'],
//             address: temp[i]['address'],
//             avaliableInternet: temp[i]['avaliableInternet'],
//             isAvalable: temp[i]['isAvalable'],
//             furnished: temp[i]['furnished'],
//             id: temp[i]['id'],
//           ),
//         );
//         break;
//     }
//   }
//   return temp2;
// }

Future<List<PropertyCardModel>> getTenPropertyCards({
  CancelToken? cancelToken,
}) async {
  final page = await PropertyCardsApiService().getProperties(
    const PropertyCardsQuery(limit: 10),
    cancelToken: cancelToken,
  );
  final temp = page.items;
  // for (int i = 0; i < 2; i++) {
  //   temp.add({
  //     'imageUrl': 'assets/images/test_photos/2.png',
  //     'propertyType': 'villa',
  //     'nameCode': 'V-2234',
  //     'numberOfRooms': 8,
  //     'sqft': 390,
  //     'leastSellPrice': 900000,
  //     'simplePropertyDescription': 'mountaim view villa',
  //     'address': 'Syria-Homs-shien',
  //     'avaliableInternet': false,
  //     'isAvalable': false,
  //     'garden': true,
  //     'id': 5,
  //   });
  // }
  // for (int i = 0; i < 2; i++) {
  //   temp.add({
  //     'imageUrl': 'assets/images/test_photos/3.jpg',
  //     'propertyType': 'apartment',
  //     'nameCode': 'A-2234',
  //     'numberOfRooms': 5,
  //     'sqft': 120,
  //     'leastSellPrice': 80000,
  //     'simplePropertyDescription': 'apparnt with view',
  //     'address': 'Syria-Homs-shien',
  //     'avaliableInternet': true,
  //     'isAvalable': true,
  //     'elevator': true,
  //     'id': 5,
  //   });
  // }
  // for (int i = 0; i < 2; i++) {
  //   temp.add({
  //     'imageUrl': 'assets/images/test_photos/4.jpg',
  //     'propertyType': 'hall',
  //     'nameCode': 'H-2234',
  //     'numberOfRooms': 1,
  //     'sqft': 190,
  //     'leastSellPrice': 55000,
  //     'simplePropertyDescription': 'playstation hall',
  //     'address': 'Syria-Homs-shien',
  //     'avaliableInternet': true,
  //     'isAvalable': true,
  //     'furnished': 'full',
  //     'id': 5,
  //   });
  // }
  // for (int i = 0; i < 2; i++) {
  //   temp.add({
  //     'imageUrl': 'assets/images/test_photos/5.jpg',
  //     'propertyType': 'store',
  //     'nameCode': 'S-2234',
  //     'numberOfRooms': 1,
  //     'sqft': 90,
  //     'leastSellPrice': 7000,
  //     'simplePropertyDescription': 'store in souk',
  //     'address': 'Syria-Homs-shien',
  //     'avaliableInternet': true,
  //     'isAvalable': true,
  //     'interface': 'glass',
  //     'id': 5,
  //   });
  // }

  return temp;
}
