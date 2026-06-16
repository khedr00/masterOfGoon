import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/employee_deals_filter_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealsFilterWidget extends StatefulWidget {
  const DealsFilterWidget({
    super.key,
    this.freshIsTrue,
    this.negIsTrue,
    this.dealStage,
    this.propertyTypes,
    this.minPriceRange,
    this.maxPriceRange,
    this.minSuccessRateRange,
    this.maxSuccessRateRange,
    this.minDateRange,
    this.maxDateRange,
    this.propertyAreas,
  });
  final bool? freshIsTrue;
  final bool? negIsTrue;
  final String? dealStage;
  final List<String>? propertyTypes;
  final List<String>? propertyAreas;

  final int? minPriceRange;
  final int? maxPriceRange;
  final int? minSuccessRateRange;
  final int? maxSuccessRateRange;
  final int? minDateRange;
  final int? maxDateRange;


  @override
  State<DealsFilterWidget> createState() => _DealsFilterWidgetState();
}

class _DealsFilterWidgetState extends State<DealsFilterWidget> {
  bool freshIsTrue = false;
  bool negIsTrue = false;
  String? dealStage;
  List<String> propertyTypes = [];
  List<String> cities = [];

  // String messageOrder = 'latest';
  // String dateOrder = 'newest';
  // String successRateOrder = 'highest';
  RangeValues priceRange = const RangeValues(0, 1000000);
  RangeValues successRateRange = const RangeValues(0, 100);
  RangeValues dateRange = const RangeValues(2020, 2026);
  @override
  Widget build(BuildContext context) {
    final employeeDealsFilterProvider =
        Provider.of<EmployeeDealsFilterProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      constraints: BoxConstraints(
        maxWidth: width * (750 / 1920),
        maxHeight: width * (855 / 1920),
      ),
      child: Container(
        width: width * (750 / 1920),
        height: width * (855 / 1920),
        padding: EdgeInsets.all(width * (25 / 1920)),
        decoration: BoxDecoration(
          color: ThemeProvider().isDarkMode
              ? darkSecondaryColor
              : secondaryColor,
          borderRadius: BorderRadius.circular(width * (15 / 1920)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filters',
                style: TextStyle(
                  fontSize: width * (32 / 1920),
                  fontFamily: 'NunitoSans-Bold',
                ),
              ),

              // الديل ستيج هان
              Padding(
                padding: EdgeInsets.symmetric(vertical: width * (10 / 1920)),
                child: Text(
                  'Deal Stage',
                  style: TextStyle(
                    fontSize: width * (20 / 1920),
                    fontFamily: 'NunitoSans-SemiBold',
                  ),
                ),
              ),
              CheckboxListTile(
                activeColor: ThemeProvider().isDarkMode
                    ? darkPrimaryColor
                    : primaryColor,
                checkboxScaleFactor: width * (1.2 / 1920),
                value: freshIsTrue,
                title: Text(
                  'Fresh',
                  style: TextStyle(
                    fontSize: width * (18 / 1920),
                    fontFamily: 'NunitoSans-Regular',
                  ),
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    value!
                        ? {negIsTrue = false, freshIsTrue = true}
                        : {freshIsTrue = false};
                  });
                },
              ),

              CheckboxListTile(
                activeColor: ThemeProvider().isDarkMode
                    ? darkPrimaryColor
                    : primaryColor,
                checkboxScaleFactor: width * (1.2 / 1920),
                value: negIsTrue,
                title: Text(
                  'Negotiation',
                  style: TextStyle(
                    fontSize: width * (18 / 1920),
                    fontFamily: 'NunitoSans-Regular',
                  ),
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    value!
                        ? {freshIsTrue = false, negIsTrue = true}
                        : {negIsTrue = false};
                  });
                },
              ),
              Divider(),

              // البروبرتي تايب
              Text(
                'Property Type',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                ),
              ),

              Wrap(
                spacing: width * (10 / 1920),
                runSpacing: width * (5 / 1920),
                children: ['House', 'Villa', 'Hall', 'Store', 'Apartment'].map((
                  type,
                ) {
                  return FilterChip(
                    label: Text(
                      type,
                      style: TextStyle(
                        fontSize: width * (18 / 1920),
                        fontFamily: 'NunitoSans-Regular',
                      ),
                    ),
                    selected: propertyTypes.contains(type),
                    onSelected: (selected) {
                      setState(() {
                        selected
                            ? propertyTypes.add(type)
                            : propertyTypes.remove(type);
                      });
                    },
                  );
                }).toList(),
              ),

              Divider(),

              // المنطقة
              Text(
                'Location',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontFamily: 'NunitoSans-Regular',
                ),
              ),

              Wrap(
                spacing: width * (10 / 1920),
                children: ['Homs', 'Hama', 'Damascus', 'Aleppo', 'Tartous'].map(
                  (city) {
                    return FilterChip(
                      label: Text(
                        city,
                        style: TextStyle(
                          fontSize: width * (18 / 1920),
                          fontFamily: 'NunitoSans-Regular',
                        ),
                      ),
                      selected: cities.contains(city),
                      onSelected: (selected) {
                        setState(() {
                          selected ? cities.add(city) : cities.remove(city);
                        });
                      },
                    );
                  },
                ).toList(),
              ),

              Divider(),

              // الترتيب

              // Text(
              //   'Sorting',
              //   style: TextStyle(
              //     fontSize: width * (18 / 1920),
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),

              // SizedBox(height: width * (10 / 1920)),

              // DropdownButtonFormField<String>(
              //   initialValue: messageOrder,
              //   decoration: const InputDecoration(labelText: 'Messages'),
              //   items: const [
              //     DropdownMenuItem(
              //       value: 'latest',
              //       child: Text('Latest Message First'),
              //     ),
              //     DropdownMenuItem(
              //       value: 'oldest',
              //       child: Text('Oldest Message First'),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       messageOrder = value!;
              //     });
              //   },
              // ),

              // SizedBox(height: width * (10 / 1920)),

              // DropdownButtonFormField<String>(
              //   initialValue: dateOrder,
              //   decoration: const InputDecoration(labelText: 'Deal Date'),
              //   items: const [
              //     DropdownMenuItem(
              //       value: 'newest',
              //       child: Text('Newest First'),
              //     ),
              //     DropdownMenuItem(
              //       value: 'oldest',
              //       child: Text('Oldest First'),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       dateOrder = value!;
              //     });
              //   },
              // ),

              // SizedBox(height: width * (10 / 1920)),

              // DropdownButtonFormField<String>(
              //   initialValue: successRateOrder,
              //   decoration: const InputDecoration(labelText: 'Success Rate'),
              //   items: const [
              //     DropdownMenuItem(
              //       value: 'highest',
              //       child: Text('Highest First'),
              //     ),
              //     DropdownMenuItem(
              //       value: 'lowest',
              //       child: Text('Lowest First'),
              //     ),
              //   ],
              //   onChanged: (value) {
              //     setState(() {
              //       successRateOrder = value!;
              //     });
              //   },
              // ),
              Divider(),

              // الرايس رانج
              Text(
                'Price Range',
                style: TextStyle(
                  fontSize: width * (20 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                ),
              ),

              RangeSlider(
                activeColor: ThemeProvider().isDarkMode
                    ? darkSecondaryColor
                    : primaryColor,
                values: priceRange,
                min: 0,
                max: 1000000,
                divisions: 100,
                labels: RangeLabels(
                  priceRange.start.round().toString(),
                  priceRange.end.round().toString(),
                ),
                onChanged: (value) {
                  setState(() {
                    priceRange = value;
                  });
                },
              ),

              // رانج السكسس ريت
              Text(
                'Success Rate (%)',
                style: TextStyle(
                  fontSize: width * (20 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                ),
              ),

              RangeSlider(
                activeColor: ThemeProvider().isDarkMode
                    ? darkSecondaryColor
                    : primaryColor,
                values: successRateRange,
                min: 0,
                max: 100,
                divisions: 100,
                labels: RangeLabels(
                  successRateRange.start.round().toString(),
                  successRateRange.end.round().toString(),
                ),
                onChanged: (value) {
                  setState(() {
                    successRateRange = value;
                  });
                },
              ),

              // رانج التاريخ
              Text(
                'Date Range',
                style: TextStyle(
                  fontSize: width * (20 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                ),
              ),

              RangeSlider(
                activeColor: ThemeProvider().isDarkMode
                    ? darkSecondaryColor
                    : primaryColor,
                values: dateRange,
                min: 2020,
                max: 2026,
                divisions: 6,
                labels: RangeLabels(
                  dateRange.start.round().toString(),
                  dateRange.end.round().toString(),
                ),
                onChanged: (value) {
                  setState(() {
                    dateRange = value;
                  });
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: width * (40 / 1920)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWithText(
                      widthOfButton: width * (150 / 1920),
                      heightOfButton: width * (40 / 1920),
                      text: 'Cancel',
                      buttonAction: () {
                        Navigator.pop(context);
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * (20 / 1920),
                      ),
                      child: ButtonWithText(
                        widthOfButton: width * (150 / 1920),
                        heightOfButton: width * (40 / 1920),
                        text: 'Apply',
                        buttonAction: () {
                          employeeDealsFilterProvider.fillFilterInfo(
                            freshIsTrue ? 'fresh' : null,
                            negIsTrue ? 'negotiation' : null,
                            dealStage,
                            propertyTypes,
                            cities,
                            priceRange.start.toInt(),
                            priceRange.end.toInt(),
                            successRateRange.start.toInt(),
                            successRateRange.end.toInt(),
                            dateRange.start.toInt(),
                            dateRange.end.toInt(),
                          );
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
