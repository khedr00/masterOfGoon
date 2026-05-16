import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PropertiesDashboardWidget extends StatelessWidget {
  const PropertiesDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (835 / 1920),
      height: width * (900 / 1920),

      decoration: BoxDecoration(
        color: Color(0xFF8FB2E3),
        borderRadius: BorderRadius.circular(width * (22 / 1920)),
      ),

      child: Padding(
        padding: EdgeInsets.all(width * (20 / 1920)),

        child: Column(
          children: [
            /// =========================
            /// TOP CARDS
            /// =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                _topCard(
                  width,
                  'Total Properties',
                  '124',
                  Icons.home_work_rounded,
                  Color(0xFF1C769B),
                ),

                _topCard(
                  width,
                  'Available',
                  '88',
                  Icons.check_circle,
                  Colors.green,
                ),

                _topCard(width, 'Sold', '21', Icons.sell, Colors.redAccent),

                _topCard(width, 'For Rent', '15', Icons.key, Colors.orange),
              ],
            ),

            SizedBox(height: width * (22 / 1920)),

            /// =========================
            /// CHARTS
            /// =========================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                /// =========================
                /// BAR CHART
                /// =========================
                Container(
                  width: width * (500 / 1920),
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

                  child: Column(
                    children: [
                      Text(
                        'Properties Types',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (22 / 1920),
                          color: Colors.black87,
                        ),
                      ),

                      Expanded(
                        child: BarChart(
                          BarChartData(
                            maxY: 40,

                            gridData: FlGridData(show: false),

                            borderData: FlBorderData(show: false),

                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),

                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),

                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: width * (28 / 1920),
                                  interval: 10,

                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),

                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Regular',
                                        fontSize: width * (12 / 1920),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: width * (34 / 1920),

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
                                        top: width * (8 / 1920),
                                      ),

                                      child: Text(
                                        text,
                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Bold',
                                          fontSize: width * (12 / 1920),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            barGroups: [
                              _bar(width, 0, 32),
                              _bar(width, 1, 24),
                              _bar(width, 2, 17),
                              _bar(width, 3, 12),
                              _bar(width, 4, 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// =========================
                /// PIE CHART
                /// =========================
                Container(
                  width: width * (260 / 1920),
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
                      Text(
                        'Regions',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),

                      SizedBox(
                        width: width * (180 / 1920),
                        height: width * (180 / 1920),

                        child: PieChart(
                          PieChartData(
                            centerSpaceRadius: width * (45 / 1920),

                            sectionsSpace: 0,

                            sections: [
                              _section(width, Colors.redAccent, 35, '35'),

                              _section(width, Colors.lightBlue, 25, '25'),

                              _section(width, Colors.green, 18, '18'),

                              _section(width, Colors.purple, 12, '12'),
                            ],
                          ),
                        ),
                      ),

                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: width * (10 / 1920),
                        runSpacing: width * (8 / 1920),

                        children: [
                          _region(width, Colors.redAccent, 'Damascus'),

                          _region(width, Colors.lightBlue, 'Aleppo'),

                          _region(width, Colors.green, 'Homs'),

                          _region(width, Colors.purple, 'Tartous'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: width * (22 / 1920)),

            /// =========================
            /// PROPERTY MINI CARDS
            /// =========================
            Expanded(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: width * (18 / 1920),
                mainAxisSpacing: width * (18 / 1920),
                childAspectRatio: 2.4,

                children: [
                  _propertyCard(
                    width,
                    'Apartment',
                    '42 Properties',
                    Icons.apartment,
                    Color(0xFF1C769B),
                  ),

                  _propertyCard(
                    width,
                    'Villa',
                    '17 Properties',
                    Icons.villa,
                    Colors.green,
                  ),

                  _propertyCard(
                    width,
                    'Office',
                    '12 Properties',
                    Icons.business_center,
                    Colors.orange,
                  ),

                  _propertyCard(
                    width,
                    'Hall',
                    '8 Properties',
                    Icons.meeting_room,
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// TOP CARD
  /// =========================

  Widget _topCard(
    double width,
    String title,
    String number,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: width * (180 / 1920),
      height: width * (110 / 1920),

      decoration: BoxDecoration(
        color: Color(0xFFDCE7F8),
        borderRadius: BorderRadius.circular(width * (16 / 1920)),

        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: Colors.black12,
            offset: Offset(0, width * (3 / 1920)),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (18 / 1920),
                    ),
                  ),
                ),

                Icon(icon, color: color, size: width * (28 / 1920)),
              ],
            ),

            Text(
              number,
              style: TextStyle(
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (42 / 1920),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// PROPERTY CARD
  /// =========================

  Widget _propertyCard(
    double width,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDCE7F8),

        borderRadius: BorderRadius.circular(width * (18 / 1920)),

        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: Colors.black12,
            offset: Offset(0, width * (3 / 1920)),
          ),
        ],
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (20 / 1920)),

        child: Row(
          children: [
            Container(
              width: width * (65 / 1920),
              height: width * (65 / 1920),

              decoration: BoxDecoration(color: color, shape: BoxShape.circle),

              child: Icon(icon, color: color, size: width * (36 / 1920)),
            ),

            SizedBox(width: width * (18 / 1920)),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (22 / 1920),
                  ),
                ),

                SizedBox(height: width * (4 / 1920)),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (18 / 1920),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// BAR
  /// =========================

  BarChartGroupData _bar(double width, int x, double y) {
    return BarChartGroupData(
      x: x,

      barRods: [
        BarChartRodData(
          toY: y,
          width: width * (24 / 1920),

          borderRadius: BorderRadius.circular(8),

          color: Color(0xFF1C769B),
        ),
      ],
    );
  }

  /// =========================
  /// PIE SECTION
  /// =========================

  PieChartSectionData _section(
    double width,
    Color color,
    double value,
    String title,
  ) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: title,

      radius: width * (42 / 1920),

      titleStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'NunitoSans-Bold',
        fontSize: width * (16 / 1920),
      ),
    );
  }

  /// =========================
  /// REGION
  /// =========================

  Widget _region(double width, Color color, String text) {
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
            fontSize: width * (13 / 1920),
          ),
        ),
      ],
    );
  }
}
