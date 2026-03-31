import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (840 / 1920),
      height: width * (346 / 1920),
      padding: EdgeInsets.all(width * (20 / 1920)),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(width * (30 / 1920)),
      ),
      child: BarChart(
        BarChartData(
          maxY: 20,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
                  return Text(
                    labels[value.toInt()],
                    style: TextStyle(color: Colors.black),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: EdgeInsets.only(top: width * (20 / 1920)),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ),
            ),

            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),

          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),

          barGroups: [
            BarChartGroupData(
              x: 0,
              barsSpace: width * (5 / 1920),
              barRods: [
                BarChartRodData(
                  toY: 8,
                  width: width * (25 / 1920),
                  color: fifthColorSecondaryLightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                BarChartRodData(
                  toY: 12,
                  width: width * (25 / 1920),
                  color: sixthColorSecondaryLightRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
              ],
            ),

            BarChartGroupData(
              x: 1,
              barsSpace: width * (5 / 1920),
              barRods: [
                BarChartRodData(
                  toY: 10,
                  width: width * (25 / 1920),
                  color: fifthColorSecondaryLightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                BarChartRodData(
                  toY: 15,
                  width: width * (25 / 1920),
                  color: sixthColorSecondaryLightRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
              ],
            ),

            BarChartGroupData(
              x: 2,
              barsSpace: width * (5 / 1920),
              barRods: [
                BarChartRodData(
                  toY: 6,
                  width: width * (25 / 1920),
                  color: fifthColorSecondaryLightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                BarChartRodData(
                  toY: 18,
                  width: width * (25 / 1920),
                  color: sixthColorSecondaryLightRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barsSpace: width * (5 / 1920),
              barRods: [
                BarChartRodData(
                  toY: 6,
                  width: width * (25 / 1920),
                  color: fifthColorSecondaryLightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                BarChartRodData(
                  toY: 18,
                  width: width * (25 / 1920),
                  color: sixthColorSecondaryLightRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barsSpace: width * (5 / 1920),
              barRods: [
                BarChartRodData(
                  toY: 15,
                  width: width * (25 / 1920),
                  color: fifthColorSecondaryLightGreen,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
                BarChartRodData(
                  toY: 4,
                  width: width * (25 / 1920),
                  color: sixthColorSecondaryLightRed,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * (5 / 1920)),
                    topRight: Radius.circular(width * (5 / 1920)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
