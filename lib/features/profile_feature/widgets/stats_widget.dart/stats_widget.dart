import 'package:flutter/material.dart';
import 'package:untitled1/features/profile_feature/widgets/stats_widget.dart/additional_stats_widget.dart';
import 'package:untitled1/features/profile_feature/widgets/stats_widget.dart/bar_chart_widget.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (887 / 1920),
      height: width * (900 / 1920),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: width * (583 / 1920),
              bottom: width * (18 / 1920),
            ),
            child: Row(
              children: [
                Container(
                  width: width * (94 / 1920),
                  height: width * (32 / 1920),
                  decoration: BoxDecoration(
                    border: Border.all(width: width * (4 / 1920)),
                  ),
                  child: Center(
                    child: Text(
                      'Year',
                      style: TextStyle(
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (16 / 1920),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * (40 / 1920)),
                  child: Container(
                    width: width * (94 / 1920),
                    height: width * (32 / 1920),
                    decoration: BoxDecoration(
                      border: Border.all(width: width * (4 / 1920)),
                    ),
                    child: Center(
                      child: Text(
                        '2025',
                        style: TextStyle(
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (16 / 1920),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: width * (45 / 1920)),
            child: BarChartWidget(),
          ),
          AdditionalStatsWidget(),
        ],
      ),
    );
  }
}
