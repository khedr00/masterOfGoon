import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:untitled1/core/widgets/constants.dart';

class EmployeesDashboardWidget extends StatelessWidget {
  const EmployeesDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (1870 / 1920),
      height: width * (600 / 1920),

      decoration: BoxDecoration(
        color: Color(0xFF8FB2E3),
        borderRadius: BorderRadius.circular(width * (24 / 1920)),
      ),

      child: Padding(
        padding: EdgeInsets.all(width * (22 / 1920)),

        child: Column(
          children: [
            /// =========================
            /// TOP STATS
            /// =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                _topCard(
                  width,
                  'Total Employees',
                  '48',
                  Icons.groups_rounded,
                  Color(0xFF1C769B),
                ),

                _topCard(
                  width,
                  'Purchasing',
                  '14',
                  Icons.shopping_cart_checkout_rounded,
                  Colors.green,
                ),

                _topCard(
                  width,
                  'Sales',
                  '12',
                  Icons.sell_rounded,
                  Colors.orange,
                ),

                _topCard(
                  width,
                  'Rent / Leasing',
                  '15',
                  Icons.key_rounded,
                  Colors.purple,
                ),

                _topCard(
                  width,
                  'Inspectors',
                  '7',
                  Icons.fact_check_rounded,
                  Colors.redAccent,
                ),
              ],
            ),

            SizedBox(height: width * (24 / 1920)),

            /// =========================
            /// MAIN CONTENT
            /// =========================
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  /// =========================
                  /// BAR CHART
                  /// =========================
                  Container(
                    width: width * (720 / 1920),
                    height: double.infinity,

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
                          'Employees Distribution',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),

                        Expanded(
                          child: BarChart(
                            BarChartData(
                              maxY: 20,

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
                                    reservedSize: width * (30 / 1920),
                                    interval: 5,

                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),

                                        style: TextStyle(
                                          fontFamily: 'NunitoSans-Regular',
                                          fontSize: width * (13 / 1920),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: width * (42 / 1920),

                                    getTitlesWidget: (value, meta) {
                                      String text = '';

                                      switch (value.toInt()) {
                                        case 0:
                                          text = 'Purchasing';
                                          break;

                                        case 1:
                                          text = 'Sales';
                                          break;

                                        case 2:
                                          text = 'Rent';
                                          break;

                                        case 3:
                                          text = 'Inspectors';
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
                                            fontSize: width * (14 / 1920),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              barGroups: [
                                _bar(width, 0, 14, Colors.green),

                                _bar(width, 1, 12, Colors.orange),

                                _bar(width, 2, 15, Colors.purple),

                                _bar(width, 3, 7, Colors.redAccent),
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
                    width: width * (420 / 1920),
                    height: double.infinity,

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
                          'Departments Ratio',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),

                        SizedBox(
                          width: width * (240 / 1920),
                          height: width * (240 / 1920),

                          child: PieChart(
                            PieChartData(
                              centerSpaceRadius: width * (60 / 1920),

                              sectionsSpace: 0,

                              sections: [
                                _section(width, Colors.green, 14, '14'),

                                _section(width, Colors.orange, 12, '12'),

                                _section(width, Colors.purple, 15, '15'),

                                _section(width, Colors.redAccent, 7, '7'),
                              ],
                            ),
                          ),
                        ),

                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: width * (14 / 1920),
                          runSpacing: width * (10 / 1920),

                          children: [
                            _legend(width, Colors.green, 'Purchasing'),

                            _legend(width, Colors.orange, 'Sales'),

                            _legend(width, Colors.purple, 'Rent'),

                            _legend(width, Colors.redAccent, 'Inspectors'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// =========================
                  /// INSPECTORS CARD
                  /// =========================
                  Container(
                    width: width * (580 / 1920),
                    height: double.infinity,

                    padding: EdgeInsets.all(width * (24 / 1920)),

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
                          'Employees Utilization',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (26 / 1920),
                          ),
                        ),

                        CircularPercentIndicator(
                          radius: width * (90 / 1920),
                          lineWidth: width * (18 / 1920),

                          percent: 0.76,

                          animation: true,

                          circularStrokeCap: CircularStrokeCap.round,

                          progressColor: primaryColor,

                          backgroundColor: Colors.white,

                          center: Text(
                            '76%',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',

                              fontSize: width * (34 / 1920),

                              color: primaryColor,
                            ),
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Text(
                        //       'Inspectors Count',
                        //       style: TextStyle(
                        //         fontFamily: 'NunitoSans-Regular',

                        //         fontSize: width * (22 / 1920),
                        //       ),
                        //     ),

                        //     SizedBox(height: width * (6 / 1920)),

                        //     Text(
                        //       '122 Employees',
                        //       style: TextStyle(
                        //         fontFamily: 'NunitoSans-Bold',

                        //         fontSize: width * (38 / 1920),

                        //         color: Colors.redAccent,
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        // Container(
                        //   width: double.infinity,
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: width * (14 / 1920),
                        //   ),

                        //   decoration: BoxDecoration(
                        //     color: primaryColor
                        //         ,

                        //     borderRadius:
                        //         BorderRadius.circular(
                        //           width * (14 / 1920),
                        //         ),
                        //   ),

                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         'Monthly Inspections',
                        //         style: TextStyle(
                        //           fontFamily:
                        //               'NunitoSans-Regular',

                        //           fontSize:
                        //               width * (18 / 1920),
                        //         ),
                        //       ),

                        //       SizedBox(
                        //         height:
                        //             width * (4 / 1920),
                        //       ),

                        //       Text(
                        //         '94 Property Check',
                        //         style: TextStyle(
                        //           fontFamily:
                        //               'NunitoSans-Bold',

                        //           fontSize:
                        //               width * (24 / 1920),

                        //           color: primaryColor,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
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
      width: width * (340 / 1920),
      height: width * (120 / 1920),

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
        padding: EdgeInsets.symmetric(horizontal: width * (18 / 1920)),

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

                      fontSize: width * (20 / 1920),
                    ),
                  ),
                ),

                Icon(icon, color: color, size: width * (30 / 1920)),
              ],
            ),

            Text(
              number,
              style: TextStyle(
                fontFamily: 'NunitoSans-Bold',

                fontSize: width * (44 / 1920),

                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// =========================
  /// BAR
  /// =========================

  BarChartGroupData _bar(double width, int x, double y, Color color) {
    return BarChartGroupData(
      x: x,

      barRods: [
        BarChartRodData(
          toY: y,

          width: width * (28 / 1920),

          borderRadius: BorderRadius.circular(8),

          color: color,
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

      radius: width * (52 / 1920),

      titleStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'NunitoSans-Bold',
        fontSize: width * (18 / 1920),
      ),
    );
  }

  /// =========================
  /// LEGEND
  /// =========================

  Widget _legend(double width, Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        Container(
          width: width * (10 / 1920),
          height: width * (10 / 1920),

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        SizedBox(width: width * (6 / 1920)),

        Text(
          text,
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (15 / 1920),
          ),
        ),
      ],
    );
  }
}
