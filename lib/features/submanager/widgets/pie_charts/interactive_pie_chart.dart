import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InteractivePieChart extends StatefulWidget {
  const InteractivePieChart({super.key});

  @override
  State<InteractivePieChart> createState() => _InteractivePieChartState();
}

class _InteractivePieChartState extends State<InteractivePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: width * (168 / 1920),
        height: width * (168 / 1920),
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (event, response) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      response == null ||
                      response.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }

                  touchedIndex = response.touchedSection!.touchedSectionIndex;
                });
              },
            ),

            sectionsSpace: 0,
            centerSpaceRadius: 0,

            sections: List.generate(3, (i) {
              final isTouched = i == touchedIndex;

              final double radius = isTouched
                  ? width * (90 / 1920)
                  : width * (80 / 1920);
              final double fontSize = isTouched
                  ? width * (20 / 1920)
                  : width * (16 / 1920);

              switch (i) {
                case 0:
                  return PieChartSectionData(
                    color: const Color.fromARGB(255, 22, 140, 63),
                    value: 47.3,
                    title: '47.3%',
                    radius: radius,
                    titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  );

                case 1:
                  return PieChartSectionData(
                    color: const Color(0xFFF2A3A3),
                    value: 13.3,
                    title: '13.3%',
                    radius: radius,
                    titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  );

                case 2:
                  return PieChartSectionData(
                    color: Colors.amber,
                    value: 39.4,
                    title: '39.4%',
                    radius: radius,
                    titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );

                default:
                  throw Error();
              }
            }),
          ),
          swapAnimationDuration: const Duration(milliseconds: 300),
          swapAnimationCurve: Curves.easeInOut,
        ),
      ),
    );
  }
}
