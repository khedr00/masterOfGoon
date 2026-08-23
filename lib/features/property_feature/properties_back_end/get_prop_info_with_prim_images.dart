import 'package:dio/dio.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/apartment_info_with_primary_images.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/hall_info_with_primary_images.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/house_info_with_primary_images.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/store_info_with_primary_images.dart';
import 'package:untitled1/features/property_feature/properties_back_end/modules/property_info_with_primary_images/villa_info_with_primary_images.dart';
import 'package:untitled1/core/modules/property-modules/nearby_place.dart';

Future<dynamic> getPropertyInfoWithPrimaryImages({
  required int id,
  CancelToken? cancelToken,
}) async {
  // try {
  // Dio dio = Dio();

  // final response = await dio.get('${base}api/v1/properties/${id.trim()}');
  // if (response.data['status'] == 'success') {}
  // final data = response.data['data'];
  // return PropertyModel.fromJson(data);
  // } on DioException catch (e) {
  //   if (CancelToken.isCancel(e)) {
  //     throw Exception('Request cancelled');
  //   }

  //   if (e.response != null) {
  //     throw Exception(e.response?.data['message'] ?? 'Server Error');
  //   }

  //   throw Exception('Connection Error getMe');
  // } catch (e) {
  //   throw Exception(e);
  // }

  Map<String, dynamic> temp = {};
  if (id == 1) {
    temp = {
      'PrimaryimageUrl': 'assets/images/test_photos/1.jpg',
      'otherImagesUlrs': [
        'assets/images/test_photos/1.jpg',
        'assets/images/test_photos/2.png',
        'assets/images/test_photos/3.jpg',
        'assets/images/test_photos/4.jpg',
      ],
      'propertyType': 'house',
      'nameCode': 'H-224',
      'numberOfRooms': 4,
      'sqft': 180,
      'leastSellPrice': 100000,
      'fakePrice': 250000,
      'simplePropertyDescription': 'suberb house view ',
      'fullPropertyDescription':
          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
      'address': 'Syria-Homs-shien',
      'outsidePainting': 'white painting',
      'avaliableInternet': true,
      'isAvaliable': true,
      'furnitureState': 'full',
      'nearByPlaces': [
        NearbyPlace(nearbyPlace: 'school', destance: 200),
        NearbyPlace(nearbyPlace: 'market', destance: 300),
        NearbyPlace(nearbyPlace: 'pharmacy', destance: 250),
      ],
      'numberOfFloors': 2,
      'outDoorPlace': ['garden', 'pool', 'parking', 'balcony'],
    };
    return HouseInfoWithPrimaryImages(
      nameCode: temp['nameCode'],
      propertyType: temp['propertyType'],
      simplePropertyDescription: temp['simplePropertyDescription'],
      fullPropertyDescription: temp['fullPropertyDescription'],
      isAvaliable: temp['isAvaliable'],
      address: temp['address'],
      leastSellPrice: temp['leastSellPrice'],
      fakePrice: temp['fakePrice'],
      sqft: temp['sqft'],
      primaryPhoto: temp['PrimaryimageUrl'],
      otherPhotos: temp['otherImagesUlrs'],
      numberOfRooms: temp['numberOfRooms'],
      outsidePainting: temp['outsidePainting'],
      furnitureState: temp['furnitureState'],
      nearByPlaces: temp['nearByPlaces'],
      numberOfFloors: temp['numberOfFloors'],
      outDoorPlace: temp['outDoorPlace'],
      avaliableInternet: temp['avaliableInternet'],
    );
  }
  if (id == 2) {
    temp = {
      'PrimaryimageUrl': 'assets/images/test_photos/1.jpg',
      'otherImagesUlrs': [
        'assets/images/test_photos/1.jpg',
        'assets/images/test_photos/2.png',
        'assets/images/test_photos/3.jpg',
        'assets/images/test_photos/4.jpg',
      ],
      'propertyType': 'villa',
      'nameCode': 'V-224',
      'numberOfRooms': 4,
      'sqft': 180,
      'leastSellPrice': 100000,
      'fakePrice': 250000,
      'simplePropertyDescription': 'suberb house view ',
      'fullPropertyDescription':
          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
      'address': 'Syria-Homs-shien',
      'outsidePainting': 'white painting',
      'avaliableInternet': true,
      'isAvaliable': true,
      'furnitureState': 'full',
      'nearByPlaces': [
        NearbyPlace(nearbyPlace: 'school', destance: 200),
        NearbyPlace(nearbyPlace: 'market', destance: 300),
        NearbyPlace(nearbyPlace: 'pharmacy', destance: 250),
      ],
      'numberOfFloors': 2,
      'outDoorPlace': ['garden', 'pool', 'parking', 'balcony'],
    };
    return VillaInfoWithPrimaryImages(
      nameCode: temp['nameCode'],
      propertyType: temp['propertyType'],
      simplePropertyDescription: temp['simplePropertyDescription'],
      fullPropertyDescription: temp['fullPropertyDescription'],
      isAvaliable: temp['isAvaliable'],
      address: temp['address'],
      leastSellPrice: temp['leastSellPrice'],
      fakePrice: temp['fakePrice'],
      sqft: temp['sqft'],
      primaryPhoto: temp['PrimaryimageUrl'],
      otherPhotos: temp['otherImagesUlrs'],
      numberOfRooms: temp['numberOfRooms'],
      outsidePainting: temp['outsidePainting'],
      furnitureState: temp['furnitureState'],
      nearByPlaces: temp['nearByPlaces'],
      numberOfFloors: temp['numberOfFloors'],
      outDoorPlace: temp['outDoorPlace'],
      avaliableInternet: temp['avaliableInternet'],
    );
  }
  if (id == 3) {
    temp = {
      'PrimaryimageUrl': 'assets/images/test_photos/1.jpg',
      'otherImagesUlrs': [
        'assets/images/test_photos/1.jpg',
        'assets/images/test_photos/2.png',
        'assets/images/test_photos/3.jpg',
        'assets/images/test_photos/4.jpg',
      ],
      'propertyType': 'apartment',
      'nameCode': 'A-224',
      'numberOfRooms': 4,
      'sqft': 180,
      'leastSellPrice': 100000,
      'fakePrice': 250000,
      'simplePropertyDescription': 'suberb house view ',
      'fullPropertyDescription':
          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
      'address': 'Syria-Homs-shien',
      'outsidePainting': 'white painting',
      'avaliableInternet': true,
      'isAvaliable': true,
      'furnitureState': 'full',
      'nearByPlaces': [
        NearbyPlace(nearbyPlace: 'school', destance: 200),
        NearbyPlace(nearbyPlace: 'market', destance: 300),
        NearbyPlace(nearbyPlace: 'pharmacy', destance: 250),
      ],
      'floorNumber': 4,
      'elevator': true,
      'buildingParking': true,
    };
    return ApartmentInfoWithPrimaryImages(
      nameCode: temp['nameCode'],
      propertyType: 'aprmnt',
      simplePropertyDescription: temp['simplePropertyDescription'],
      fullPropertyDescription: temp['fullPropertyDescription'],
      isAvaliable: temp['isAvaliable'],
      address: temp['address'],
      leastSellPrice: temp['leastSellPrice'],
      fakePrice: temp['fakePrice'],
      sqft: temp['sqft'],
      primaryPhoto: temp['PrimaryimageUrl'],
      otherPhotos: temp['otherImagesUlrs'],
      numberOfRooms: temp['numberOfRooms'],
      outsidePainting: temp['outsidePainting'],
      furnitureState: temp['furnitureState'],
      nearByPlaces: temp['nearByPlaces'],
      floorNumber: temp['floorNumber'],
      elevator: temp['elevator'],
      buildingParking: temp['buildingParking'],
      avaliableInternet: temp['avaliableInternet'],
    );
  }
  if (id == 4) {
    temp = {
      'PrimaryimageUrl': 'assets/images/test_photos/1.jpg',
      'otherImagesUlrs': [
        'assets/images/test_photos/1.jpg',
        'assets/images/test_photos/2.png',
        'assets/images/test_photos/3.jpg',
        'assets/images/test_photos/4.jpg',
      ],
      'propertyType': 'store',
      'nameCode': 'S-224',
      'numberOfRooms': 4,
      'sqft': 180,
      'leastSellPrice': 100000,
      'fakePrice': 250000,
      'simplePropertyDescription': 'suberb house view ',
      'fullPropertyDescription':
          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
      'address': 'Syria-Homs-shien',
      'outsidePainting': 'white painting',
      'avaliableInternet': true,
      'isAvaliable': true,
      'furnitureState': 'full',
      'nearByPlaces': [
        NearbyPlace(nearbyPlace: 'school', destance: 200),
        NearbyPlace(nearbyPlace: 'market', destance: 300),
        NearbyPlace(nearbyPlace: 'pharmacy', destance: 250),
      ],
      'floorNumber': 2,
      'storeFront':
          'LKHVCDHVCADHVCLAHDVCLAHVCLAVHCLADHVCLADHCVLAHDCVLAVHCLADCVLADHCVDCLACL',
    };
    return StoreInfoWithPrimaryImages(
      nameCode: temp['nameCode'],
      propertyType: temp['propertyType'],
      simplePropertyDescription: temp['simplePropertyDescription'],
      fullPropertyDescription: temp['fullPropertyDescription'],
      isAvaliable: temp['isAvaliable'],
      address: temp['address'],
      leastSellPrice: temp['leastSellPrice'],
      fakePrice: temp['fakePrice'],
      sqft: temp['sqft'],
      primaryPhoto: temp['PrimaryimageUrl'],
      otherPhotos: temp['otherImagesUlrs'],
      numberOfRooms: temp['numberOfRooms'],
      outsidePainting: temp['outsidePainting'],
      furnitureState: temp['furnitureState'],
      nearByPlaces: temp['nearByPlaces'],
      floorNumber: temp['floorNumber'],
      storeFront: temp['storeFront'],
      avaliableInternet: temp['avaliableInternet'],
    );
  }
  if (id == 5) {
    temp = {
      'PrimaryimageUrl': 'assets/images/test_photos/1.jpg',
      'otherImagesUlrs': [
        'assets/images/test_photos/1.jpg',
        'assets/images/test_photos/2.png',
        'assets/images/test_photos/3.jpg',
        'assets/images/test_photos/4.jpg',
      ],
      'propertyType': 'hall',
      'nameCode': 'HA-224',
      'numberOfRooms': 4,
      'sqft': 180,
      'leastSellPrice': 100000,
      'fakePrice': 250000,
      'simplePropertyDescription': 'suberb house view ',
      'fullPropertyDescription':
          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
      'address': 'Syria-Homs-shien',
      'outsidePainting': 'white painting',
      'avaliableInternet': true,
      'isAvaliable': true,
      'furnitureState': 'full',
      'nearByPlaces': [
        NearbyPlace(nearbyPlace: 'school', destance: 200),
        NearbyPlace(nearbyPlace: 'market', destance: 300),
        NearbyPlace(nearbyPlace: 'pharmacy', destance: 250),
      ],
      'floorNumber': 2,
    };
    return HallInfoWithPrimaryImages(
      nameCode: temp['nameCode'],
      propertyType: temp['propertyType'],
      simplePropertyDescription: temp['simplePropertyDescription'],
      fullPropertyDescription: temp['fullPropertyDescription'],
      isAvaliable: temp['isAvaliable'],
      address: temp['address'],
      leastSellPrice: temp['leastSellPrice'],
      fakePrice: temp['fakePrice'],
      sqft: temp['sqft'],
      primaryPhoto: temp['PrimaryimageUrl'],
      otherPhotos: temp['otherImagesUlrs'],
      numberOfRooms: temp['numberOfRooms'],
      outsidePainting: temp['outsidePainting'],
      furnitureState: temp['furnitureState'],
      nearByPlaces: temp['nearByPlaces'],
      floorNumber: temp['floorNumber'],
      avaliableInternet: temp['avaliableInternet'],
    );
  }
  return StoreInfoWithPrimaryImages(
    nameCode: temp['nameCode'],
    propertyType: temp['propertyType'],
    simplePropertyDescription: temp['simplePropertyDescription'],
    fullPropertyDescription: temp['fullPropertyDescription'],
    isAvaliable: temp['isAvaliable'],
    address: temp['address'],
    leastSellPrice: temp['leastSellPrice'],
    fakePrice: temp['fakePrice'],
    sqft: temp['sqft'],
    primaryPhoto: temp['PrimaryimageUrl'],
    otherPhotos: temp['otherImagesUlrs'],
    numberOfRooms: temp['numberOfRooms'],
    outsidePainting: temp['outsidePainting'],
    furnitureState: temp['furnitureState'],
    nearByPlaces: temp['nearByPlaces'],
    floorNumber: temp['floorNumber'],
    storeFront: temp['storeFront'],
    avaliableInternet: temp['avaliableInternet'],
  );
}
