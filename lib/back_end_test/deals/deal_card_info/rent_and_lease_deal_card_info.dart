import 'package:untitled1/back_end_test/deals/deal_card_info/deal_card_info.dart';

class RentAndLeaseDealCardInfo extends DealCardInfo {
  RentAndLeaseDealCardInfo({
    required super.id,
    required super.propertyId,
    required super.clientId,
    required super.title,
    required super.dealStage,
    required super.successProbability,
    required super.startingDate,
    required super.clientName,
    required super.clientPhoto,
    required super.propertyPrimaryImage,
    required super.propertyType,
    required super.propertyPrice,
    required super.propertySimpleDescription,
    required super.propertyAddress,
    required this.rentalPeriod,
  });
  final int rentalPeriod;
}
