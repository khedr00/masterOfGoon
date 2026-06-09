import 'package:flutter/material.dart';

class EmployeeDealsFilterProvider extends ChangeNotifier {
  String? freshIsTrue;
  String? negIsTrue;
  String? dealStage;
  List<String>? propertyTypes;
  List<String>? cities;

  int? minPriceRange;
  int? maxPriceRange;
  int? minSuccessRateRange;
  int? maxSuccessRateRange;
  int? minDateRange;
  int? maxDateRange;

  // Widget get getPageSelected => pageSelected!;

  void fillFilterInfo(
    String? newFreshIsTrue,
    String? newNegIsTrue,
    String? newDealStage,
    List<String>? newPropertyTypes,
    List<String>? newCities,

    int? newMinPriceRange,
    int? newMaxPriceRange,
    int? newMinSuccessRateRange,
    int? newMaxSuccessRateRange,
    int? newMinDateRange,
    int? newMaxDateRange,
  ) {
    freshIsTrue = newFreshIsTrue;
    negIsTrue = newNegIsTrue;
    dealStage = newDealStage;
    propertyTypes = newPropertyTypes;
    cities = newCities;

    minPriceRange = newMinPriceRange;
    maxPriceRange = newMaxPriceRange;

    minSuccessRateRange = newMinSuccessRateRange;
    maxSuccessRateRange = newMaxSuccessRateRange;

    minDateRange = newMinDateRange;
    maxDateRange = newMaxDateRange;
    notifyListeners();
  }
}
