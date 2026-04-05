import 'package:dio/dio.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/property_info_inside_deal_card.dart';

Future<PropertyInfoInsideDealCard> getPropertyInfoInsideDealCard({
  required int propertyId,
  CancelToken? cancelToken,
}) async {
  await Future.delayed(const Duration(seconds: 3));
  if (propertyId == 1) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'villa',
      propertyPrice: 30000,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies ',
      propertyAddress: 'homs_shien',
    );
  }
  if (propertyId == 2) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'house',
      propertyPrice: 30001,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies 1',
      propertyAddress: 'homs_shien1',
    );
  }
  if (propertyId == 3) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'aprmnt',
      propertyPrice: 30002,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies 2',
      propertyAddress: 'homs_shien2',
    );
  }
  if (propertyId == 4) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'hall',
      propertyPrice: 30003,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies 3',
      propertyAddress: 'homs_shien3',
    );
  }
  if (propertyId == 5) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'store',
      propertyPrice: 30004,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies 4',
      propertyAddress: 'homs_shien4',
    );
  }
  if (propertyId == 6) {
    return PropertyInfoInsideDealCard(
      propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
      propertyType: 'house',
      propertyPrice: 30005,
      propertySimpleDescription:
          'Furnished Apartment with pool and 2 balconies 5',
      propertyAddress: 'homs_shien5',
    );
  }
  return PropertyInfoInsideDealCard(
    propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
    propertyType: 'house',
    propertyPrice: 30001,
    propertySimpleDescription:
        'Furnished Apartment with pool and 2 balconies 1',
    propertyAddress: 'homs_shien1',
  );
}
