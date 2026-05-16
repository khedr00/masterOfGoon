import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (1032 / 1920),
      height: width * (900 / 1920),
      padding: EdgeInsets.all(width * (18 / 1920)),
      decoration: BoxDecoration(
        color: const Color(0xFF8FB0E0),
        borderRadius: BorderRadius.circular(width * (18 / 1920)),
      ),

      child: Column(
        children: [
          /// TOP CARDS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _topCard(
                width,
                title: 'Open Deals',
                value: '25',
                valueColor: const Color(0xFF136B8A),
              ),

              _topCard(
                width,
                title: 'Successful Deals:',
                value: '10',
                valueColor: Colors.green,
              ),

              _topCard(
                width,
                title: 'Lost Deals:',
                value: '7',
                valueColor: Colors.red.shade900,
              ),

              _topCard(
                width,
                title: 'Deal Success Rate',
                value: '70%',
                valueColor: const Color(0xFF136B8A),
              ),

              _topCard(
                width,
                title: 'New Leads',
                value: '7',
                valueColor: const Color(0xFF136B8A),
              ),
            ],
          ),

          SizedBox(height: width * (26 / 1920)),

          /// CENTER SECTION
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// BAR CHART
              /// ===============================
              /// BAR CHART SECTION
              /// ===============================
              Container(
                width: width * (560 / 1920),
                height: width * (320 / 1920),
                padding: EdgeInsets.all(width * (18 / 1920)),
                decoration: BoxDecoration(
                  color: Color(0xFFDCE7F8),
                  borderRadius: BorderRadius.circular(width * (18 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: width * (8 / 1920),
                      color: Colors.black12,
                      offset: Offset(0, width * (3 / 1920)),
                    ),
                  ],
                ),

                child: BarChart(
                  BarChartData(
                    maxY: 45,
                    alignment: BarChartAlignment.spaceAround,

                    gridData: FlGridData(show: false),

                    borderData: FlBorderData(show: false),

                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),

                      /// LEFT NUMBERS
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: width * (32 / 1920),
                          interval: 10,

                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: width * (8 / 1920),
                              ),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Bold',
                                  fontSize: width * (13 / 1920),
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      /// BOTTOM LABELS
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: width * (40 / 1920),

                          getTitlesWidget: (value, meta) {
                            String text = '';

                            switch (value.toInt()) {
                              case 0:
                                text = 'Apartment';
                                break;

                              case 1:
                                text = 'House';
                                break;

                              case 2:
                                text = 'Villa';
                                break;

                              case 3:
                                text = 'Office';
                                break;

                              case 4:
                                text = 'Hall';
                                break;
                            }

                            return Padding(
                              padding: EdgeInsets.only(
                                top: width * (10 / 1920),
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Bold',
                                  fontSize: width * (14 / 1920),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    /// BARS
                    barGroups: [
                      /// Apartment
                      BarChartGroupData(
                        x: 0,
                        barsSpace: width * (4 / 1920),
                        barRods: [
                          BarChartRodData(
                            toY: 36,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF17769E),
                          ),

                          BarChartRodData(
                            toY: 29,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),

                          BarChartRodData(
                            toY: 23,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),

                      /// House
                      BarChartGroupData(
                        x: 1,
                        barsSpace: width * (4 / 1920),
                        barRods: [
                          BarChartRodData(
                            toY: 24,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF17769E),
                          ),

                          BarChartRodData(
                            toY: 30,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),

                          BarChartRodData(
                            toY: 10,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),

                      /// Villa
                      BarChartGroupData(
                        x: 2,
                        barsSpace: width * (4 / 1920),
                        barRods: [
                          BarChartRodData(
                            toY: 24,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF17769E),
                          ),

                          BarChartRodData(
                            toY: 11,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),

                          BarChartRodData(
                            toY: 15,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),

                      /// Office
                      BarChartGroupData(
                        x: 3,
                        barsSpace: width * (4 / 1920),
                        barRods: [
                          BarChartRodData(
                            toY: 37,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF17769E),
                          ),

                          BarChartRodData(
                            toY: 26,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),

                          BarChartRodData(
                            toY: 15,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),

                      /// HALL
                      BarChartGroupData(
                        x: 4,
                        barsSpace: width * (4 / 1920),
                        barRods: [
                          BarChartRodData(
                            toY: 19,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFF17769E),
                          ),

                          BarChartRodData(
                            toY: 13,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green,
                          ),

                          BarChartRodData(
                            toY: 8,
                            width: width * (14 / 1920),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.shade700,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: width * (24 / 1920)),

              /// BIG PIE CHART
              /// ===============================
              /// PIE CHART SECTION
              /// ===============================
              Container(
                width: width * (360 / 1920),
                height: width * (320 / 1920),

                decoration: BoxDecoration(
                  color: Color(0xFFDCE7F8),
                  borderRadius: BorderRadius.circular(width * (18 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: width * (8 / 1920),
                      color: Colors.black12,
                      offset: Offset(0, width * (3 / 1920)),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (210 / 1920),
                      height: width * (210 / 1920),

                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: width * (55 / 1920),

                          sectionsSpace: 0,

                          sections: [
                            PieChartSectionData(
                              color: Colors.redAccent,
                              value: 14,
                              title: '14',
                              radius: width * (48 / 1920),
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),

                            PieChartSectionData(
                              color: Colors.pinkAccent,
                              value: 5,
                              title: '5',
                              radius: width * (48 / 1920),
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),

                            PieChartSectionData(
                              color: Colors.green,
                              value: 3,
                              title: '3',
                              radius: width * (48 / 1920),
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),

                            PieChartSectionData(
                              color: Colors.lightBlue,
                              value: 7,
                              title: '7',
                              radius: width * (48 / 1920),
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),

                            PieChartSectionData(
                              color: Colors.purple,
                              value: 6,
                              title: '6',
                              radius: width * (48 / 1920),
                              titleStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (18 / 1920),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// REGIONS
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: width * (14 / 1920),
                      runSpacing: width * (10 / 1920),

                      children: [
                        _buildRegion(width, Colors.redAccent, 'Damascus'),

                        _buildRegion(width, Colors.pinkAccent, 'Tartous'),

                        _buildRegion(width, Colors.green, 'Homs'),

                        _buildRegion(width, Colors.lightBlue, 'Aleppo'),

                        _buildRegion(width, Colors.purple, 'Hama'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: width * (34 / 1920)),

          Divider(thickness: width * (1 / 1920), color: Colors.black26),

          SizedBox(height: width * (20 / 1920)),

          /// BOTTOM PIE CHARTS
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _smallPie(width, title: 'Open Deals:', value: '25'),

                _smallPie(width, title: 'Successful Deals:', value: '10'),

                _smallPie(width, title: 'Lost Deals:', value: '7'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// TOP CARD
  Widget _topCard(
    double width, {
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      width: width * (190 / 1920),
      height: width * (98 / 1920),

      decoration: BoxDecoration(
        color: const Color(0xFFD9E4F7),
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (8 / 1920),
            color: Colors.black12,
            offset: Offset(0, width * (4 / 1920)),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'NunitoSans-Regular',
              fontSize: width * (16 / 1920),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontFamily: 'NunitoSans-Bold',
              fontSize: width * (40 / 1920),
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  /// SMALL PIE
  Widget _smallPie(
    double width, {
    required String title,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (24 / 1920),
          ),
        ),

        SizedBox(height: width * (18 / 1920)),

        SizedBox(
          width: width * (220 / 1920),
          height: width * (220 / 1920),

          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  centerSpaceRadius: width * (52 / 1920),
                  sectionsSpace: 2,

                  sections: [
                    PieChartSectionData(
                      value: 8,
                      color: Colors.green,
                      radius: width * (48 / 1920),
                      title: '',
                    ),

                    PieChartSectionData(
                      value: 17,
                      color: Colors.lightBlue,
                      radius: width * (48 / 1920),
                      title: '',
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (38 / 1920),
                    ),
                  ),

                  Text(
                    'deals',
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (15 / 1920),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: width * (10 / 1920)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * (10 / 1920),
              height: width * (10 / 1920),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: width * (5 / 1920)),

            Text(
              'Rent',
              style: TextStyle(
                fontFamily: 'NunitoSans-Regular',
                fontSize: width * (16 / 1920),
              ),
            ),

            SizedBox(width: width * (14 / 1920)),

            Container(
              width: width * (10 / 1920),
              height: width * (10 / 1920),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: width * (5 / 1920)),

            Text(
              'Sold',
              style: TextStyle(
                fontFamily: 'NunitoSans-Regular',
                fontSize: width * (16 / 1920),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// ===============================
/// REGION WIDGET
/// ===============================

Widget _buildRegion(double width, Color color, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: width * (10 / 1920),
        height: width * (10 / 1920),

        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),

      SizedBox(width: width * (5 / 1920)),

      Text(
        text,
        style: TextStyle(
          fontFamily: 'NunitoSans-Regular',
          fontSize: width * (14 / 1920),
          color: Colors.black87,
        ),
      ),
    ],
  );
}
