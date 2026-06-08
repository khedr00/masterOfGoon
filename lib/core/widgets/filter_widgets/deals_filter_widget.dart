import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealsFilterWidget extends StatefulWidget {
  const DealsFilterWidget({super.key});

  @override
  State<DealsFilterWidget> createState() => _DealsFilterWidgetState();
}

class _DealsFilterWidgetState extends State<DealsFilterWidget> {
  bool? test = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String? dealStage;

    List<String> propertyTypes = [];
    List<String> cities = [];

    String messageOrder = 'latest';
    String dateOrder = 'newest';
    String successRateOrder = 'highest';

    RangeValues priceRange = const RangeValues(0, 1000000);
    RangeValues successRateRange = const RangeValues(0, 100);
    RangeValues dateRange = const RangeValues(2020, 2026);
    return Dialog(
      constraints: BoxConstraints(
        maxWidth: width * (750 / 1920),
        maxHeight: width * (700 / 1920),
      ),
      child: Container(
        width: width * (750 / 1920),
        height: width * (700 / 1920),
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
                  fontSize: width * (24 / 1920),
                  fontFamily: 'NunitoSans-Bold',
                ),
              ),

              SizedBox(height: width * (20 / 1920)),

              //////////////////////////////////////////////////////
              /// DEAL STAGE
              //////////////////////////////////////////////////////
              Text(
                'Deal Stage',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontFamily: 'NunitoSans-SemiBold',
                ),
              ),

              CheckboxListTile(
                value: test,
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
                    test = value!;
                  });
                },
              ),

              // CheckboxListTile(
              //   value: dealStage == 'negotiation',
              //   title: Text(
              //     'Negotiation',
              //     style: TextStyle(
              //       fontSize: width * (18 / 1920),
              //       fontFamily: 'NunitoSans-Regular',
              //     ),
              //   ),
              //   dense: true,
              //   contentPadding: EdgeInsets.zero,
              //   onChanged: (value) {
              //     setDialogState(() {
              //       dealStage = 'fresh';
              //     });
              //   },
              // ),
              Divider(),

              //////////////////////////////////////////////////////
              /// PROPERTY TYPE
              //////////////////////////////////////////////////////
              Text(
                'Property Type',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              Wrap(
                spacing: 10,
                runSpacing: 0,
                children: ['House', 'Villa', 'Hall', 'Store', 'Apartment'].map((
                  type,
                ) {
                  return FilterChip(
                    label: Text(type),
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

              //////////////////////////////////////////////////////
              /// CITY
              //////////////////////////////////////////////////////
              Text(
                'Location',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              Wrap(
                spacing: 10,
                children: ['Homs', 'Hama', 'Damascus', 'Aleppo', 'Tartous'].map(
                  (city) {
                    return FilterChip(
                      label: Text(city),
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

              //////////////////////////////////////////////////////
              /// SORTING
              //////////////////////////////////////////////////////
              Text(
                'Sorting',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: width * (10 / 1920)),

              DropdownButtonFormField<String>(
                initialValue: messageOrder,
                decoration: const InputDecoration(labelText: 'Messages'),
                items: const [
                  DropdownMenuItem(
                    value: 'latest',
                    child: Text('Latest Message First'),
                  ),
                  DropdownMenuItem(
                    value: 'oldest',
                    child: Text('Oldest Message First'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    messageOrder = value!;
                  });
                },
              ),

              SizedBox(height: width * (10 / 1920)),

              DropdownButtonFormField<String>(
                initialValue: dateOrder,
                decoration: const InputDecoration(labelText: 'Deal Date'),
                items: const [
                  DropdownMenuItem(
                    value: 'newest',
                    child: Text('Newest First'),
                  ),
                  DropdownMenuItem(
                    value: 'oldest',
                    child: Text('Oldest First'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    dateOrder = value!;
                  });
                },
              ),

              SizedBox(height: width * (10 / 1920)),

              DropdownButtonFormField<String>(
                initialValue: successRateOrder,
                decoration: const InputDecoration(labelText: 'Success Rate'),
                items: const [
                  DropdownMenuItem(
                    value: 'highest',
                    child: Text('Highest First'),
                  ),
                  DropdownMenuItem(
                    value: 'lowest',
                    child: Text('Lowest First'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    successRateOrder = value!;
                  });
                },
              ),

              Divider(),

              //////////////////////////////////////////////////////
              /// PRICE RANGE
              //////////////////////////////////////////////////////
              Text(
                'Price Range',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              RangeSlider(
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

              //////////////////////////////////////////////////////
              /// SUCCESS RATE RANGE
              //////////////////////////////////////////////////////
              Text(
                'Success Rate (%)',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              RangeSlider(
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

              //////////////////////////////////////////////////////
              /// DATE RANGE
              //////////////////////////////////////////////////////
              Text(
                'Date Range',
                style: TextStyle(
                  fontSize: width * (18 / 1920),
                  fontWeight: FontWeight.w600,
                ),
              ),

              RangeSlider(
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

              SizedBox(height: width * (20 / 1920)),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),

                  SizedBox(width: width * (10 / 1920)),

                  ElevatedButton(
                    onPressed: () {
                      // APPLY FILTERS HERE
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
