import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class GeneralmanagerHomePage extends StatefulWidget {
  const GeneralmanagerHomePage({super.key});

  @override
  State<GeneralmanagerHomePage> createState() => _GeneralmanagerHomePageState();
}

class _GeneralmanagerHomePageState extends State<GeneralmanagerHomePage> {
  final List<String> areas = ['Damascus', 'Hama', 'Homs', 'Tartous', 'Aleppo'];

  final List<String> propertyTypes = [
    'Apartment',
    'Villa',
    'Office',
    'Store + Office',
    'All Types',
  ];

  final List<String> margins = ['10%', '12%', '15%', '18%', '20%', '25%'];

  late List<String> selectedAreas;
  late List<String> selectedTypes;
  late List<String> selectedSaleMargins;
  late List<String> selectedRentMargins;

  @override
  void initState() {
    super.initState();

    selectedAreas = ['Damascus', 'Hama', 'Homs', 'Tartous', 'Aleppo'];

    selectedTypes = [
      'Apartment',
      'Villa',
      'Office',
      'Store + Office',
      'All Types',
    ];

    selectedSaleMargins = ['20%', '25%', '18%', '18%', '18%'];

    selectedRentMargins = ['12%', '15%', '10%', '10%', '10%'];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (1920 / 1920),
      height: width * (882 / 1920),
      color: backGroundColor,

      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * (40 / 1920),
          vertical: width * (20 / 1920),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// LEFT SIDE
            Expanded(
              child: Column(
                children: [
                  /// TOP CARDS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      _topCard(
                        width,
                        title: 'Total Revenue',
                        value: '\$2,580,000',
                        icon: Icons.attach_money_rounded,
                      ),

                      _topCard(
                        width,
                        title: 'Net Profit',
                        value: '\$1,340,000',
                        icon: Icons.account_balance_wallet_rounded,
                      ),

                      _topCard(
                        width,
                        title: 'Profit Margin',
                        value: '52%',
                        icon: Icons.percent_rounded,
                      ),

                      _topCard(
                        width,
                        title: 'Monthly Growth',
                        value: '\$1,340,000',
                        icon: Icons.trending_up_rounded,
                      ),
                    ],
                  ),

                  SizedBox(height: width * (45 / 1920)),

                  /// TABLE SECTION
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(
                          width * (28 / 1920),
                        ),

                        boxShadow: [
                          BoxShadow(
                            blurRadius: width * (8 / 1920),
                            color: Colors.black26,
                            offset: Offset(0, width * (4 / 1920)),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          /// HEADER
                          Container(
                            width: double.infinity,
                            height: width * (100 / 1920),

                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * (28 / 1920)),
                                topRight: Radius.circular(width * (28 / 1920)),
                              ),
                            ),

                            child: Padding(
                              padding: EdgeInsets.only(
                                left: width * (45 / 1920),
                              ),

                              child: Align(
                                alignment: Alignment.centerLeft,

                                child: Text(
                                  'Pricing Margin & Rules',
                                  style: TextStyle(
                                    fontFamily: 'NunitoSans-Bold',
                                    color: Colors.white,
                                    fontSize: width * (30 / 1920),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * (28 / 1920),
                                vertical: width * (24 / 1920),
                              ),

                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      _tableTitle(width, 'Area'),
                                      _tableTitle(width, 'Type'),
                                      _tableTitle(width, 'Sale Margin'),
                                      _tableTitle(width, 'Rent Margin'),
                                    ],
                                  ),

                                  SizedBox(height: width * (16 / 1920)),

                                  Expanded(
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),

                                      itemCount: 5,

                                      separatorBuilder: (_, _) =>
                                          SizedBox(height: width * (14 / 1920)),

                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            _dropDownBox(
                                              width,
                                              value: selectedAreas[index],
                                              items: areas,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedAreas[index] = value!;
                                                });
                                              },
                                            ),

                                            _dropDownBox(
                                              width,
                                              value: selectedTypes[index],
                                              items: propertyTypes,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedTypes[index] = value!;
                                                });
                                              },
                                            ),

                                            _dropDownBox(
                                              width,
                                              value: selectedSaleMargins[index],
                                              items: margins,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedSaleMargins[index] =
                                                      value!;
                                                });
                                              },
                                            ),

                                            _dropDownBox(
                                              width,
                                              value: selectedRentMargins[index],
                                              items: margins,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRentMargins[index] =
                                                      value!;
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: width * (35 / 1920)),

            /// RIGHT SIDE
            SizedBox(
              width: width * (500 / 1920),

              child: Column(
                children: [
                  /// BUSINESS HEALTH
                  Container(
                    width: double.infinity,
                    height: width * (430 / 1920),

                    decoration: BoxDecoration(
                      color: const Color(0xFF8BC2CF),

                      borderRadius: BorderRadius.circular(width * (24 / 1920)),

                      boxShadow: [
                        BoxShadow(
                          blurRadius: width * (8 / 1920),
                          color: Colors.black26,
                          offset: Offset(0, width * (4 / 1920)),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: width * (78 / 1920),

                          decoration: BoxDecoration(
                            color: const Color(0xFF2E8F90),

                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * (24 / 1920)),
                              topRight: Radius.circular(width * (24 / 1920)),
                            ),
                          ),

                          child: Center(
                            child: Text(
                              'Business Health Indicator',
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (25 / 1920),
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),

                        Expanded(
                          child: Column(
                            children: [
                              _healthRow(
                                width,
                                image: 'assets/images/Handshake.png',
                                title: 'Active deals',
                                value: '22',
                              ),

                              _healthRow(
                                width,
                                icon: Icons.home_work_rounded,
                                title: 'Idle properties',
                                value: '40',
                              ),

                              _healthRow(
                                width,
                                icon: Icons.warning_rounded,
                                title: 'High Risk Deals',
                                value: '8',
                              ),

                              _healthRow(
                                width,
                                image: 'assets/images/profilePhoto-icon.png',
                                title: 'Employee Utilization',
                                value: '69%',
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: width * (28 / 1920)),

                  /// ALERTS
                  Expanded(
                    child: Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius: BorderRadius.circular(
                          width * (24 / 1920),
                        ),

                        border: Border.all(
                          color: Colors.red,
                          width: width * (2 / 1920),
                        ),
                      ),

                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: width * (78 / 1920),

                            decoration: BoxDecoration(
                              color: const Color(0xFFAA1116),

                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(width * (24 / 1920)),
                                topRight: Radius.circular(width * (24 / 1920)),
                              ),
                            ),

                            child: Center(
                              child: Text(
                                'Alerts',
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Bold',
                                  color: Colors.white,
                                  fontSize: width * (32 / 1920),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(width * (20 / 1920)),

                              child: ListView.separated(
                                physics: const BouncingScrollPhysics(),

                                itemCount: 3,

                                separatorBuilder: (_, _) =>
                                    SizedBox(height: width * (16 / 1920)),

                                itemBuilder: (context, index) {
                                  List<String> alerts = [
                                    '12 properties have been Idle\nfor over 90 days',
                                    'Revenue in Homs dropped by\n50% this month',
                                    'Employee Productivity have\ndecreased by 6%',
                                  ];

                                  return _alertCard(width, alerts[index]);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topCard(
    double width, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: width * (260 / 1920),
      height: width * (150 / 1920),

      decoration: BoxDecoration(
        color: primaryColor,

        borderRadius: BorderRadius.circular(width * (12 / 1920)),

        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: Colors.black26,
            offset: Offset(0, width * (3 / 1920)),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.all(width * (18 / 1920)),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white, size: width * (34 / 1920)),

                SizedBox(width: width * (12 / 1920)),

                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      color: Colors.white,
                      fontSize: width * (17 / 1920),
                    ),
                  ),
                ),
              ],
            ),

            Center(
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  color: Colors.white,
                  fontSize: width * (28 / 1920),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableTitle(double width, String title) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'NunitoSans-Bold',
          fontSize: width * (22 / 1920),
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _dropDownBox(
    double width, {
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: width * (18 / 1920)),

        child: Container(
          height: width * (68 / 1920),

          padding: EdgeInsets.symmetric(horizontal: width * (12 / 1920)),

          decoration: BoxDecoration(
            color: const Color(0xFFE8E4DB),

            borderRadius: BorderRadius.circular(width * (6 / 1920)),
          ),

          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,

              dropdownColor: const Color(0xFFE8E4DB),

              style: TextStyle(
                fontFamily: 'NunitoSans-Regular',
                color: Colors.black87,
                fontSize: width * (17 / 1920),
              ),

              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: primaryColor,
                size: width * (30 / 1920),
              ),

              onChanged: onChanged,

              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _healthRow(
    double width, {
    IconData? icon,
    String? image,
    required String title,
    required String value,
    bool isLast = false,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: width * (1 / 1920),
                  ),
                ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (24 / 1920)),

          child: Row(
            children: [
              image != null
                  ? Image.asset(
                      image,
                      width: width * (42 / 1920),
                      height: width * (42 / 1920),
                    )
                  : Icon(icon, size: width * (42 / 1920), color: primaryColor),

              SizedBox(width: width * (18 / 1920)),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (18 / 1920),
                    color: Colors.black,
                  ),
                ),
              ),

              Text(
                value,
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (34 / 1920),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertCard(double width, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * (26 / 1920),
        vertical: width * (18 / 1920),
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF04C4E),

        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'NunitoSans-Regular',
          color: Colors.white,
          fontSize: width * (16 / 1920),
        ),
      ),
    );
  }
}
