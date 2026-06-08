import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class EmployeesDashboardWidget extends StatefulWidget {
  const EmployeesDashboardWidget({super.key});

  @override
  State<EmployeesDashboardWidget> createState() =>
      _EmployeesDashboardWidgetState();
}

class _EmployeesDashboardWidgetState extends State<EmployeesDashboardWidget> {
  static const List<String> _departments = [
    'All',
    'Purchasing',
    'Sales',
    'Rent',
  ];

  static const Map<String, List<double>> _distributionData = {
    'All': [18, 22, 8],
    'Purchasing': [6, 6, 2],
    'Sales': [5, 5, 2],
    'Rent': [5, 7, 3],
  };

  String _selectedDepartment = 'All';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (1870 / 1920),
      height: width * (600 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkSecondaryColor : const Color(0xFF8FB2E3),
        borderRadius: BorderRadius.circular(width * (24 / 1920)),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * (22 / 1920)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _topCard(
                  width,
                  'Total Employees',
                  '48',
                  Icons.groups_rounded,
                  themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF1C769B),
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * (1160 / 1920),
                    height: double.infinity,
                    padding: EdgeInsets.all(width * (18 / 1920)),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
                      borderRadius: BorderRadius.circular(width * (18 / 1920)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: width * (8 / 1920),
                          color: themeProvider.isDarkMode ? Colors.black54 : Colors.black12,
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
                            color: getPrimaryTextColor(themeProvider.isDarkMode),
                          ),
                        ),
                        SizedBox(height: width * (10 / 1920)),
                        _departmentFilter(width),
                        SizedBox(height: width * (8 / 1920)),
                        Expanded(child: _distributionChart(width)),
                      ],
                    ),
                  ),
                  Container(
                    width: width * (580 / 1920),
                    height: double.infinity,
                    padding: EdgeInsets.all(width * (24 / 1920)),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
                      borderRadius: BorderRadius.circular(width * (18 / 1920)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: width * (8 / 1920),
                          color: themeProvider.isDarkMode ? Colors.black54 : Colors.black12,
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
                            color: getPrimaryTextColor(themeProvider.isDarkMode),
                          ),
                        ),
                        CircularPercentIndicator(
                          radius: width * (90 / 1920),
                          lineWidth: width * (18 / 1920),
                          percent: 0.76,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                          backgroundColor: getCardColor(themeProvider.isDarkMode),
                          center: Text(
                            '76%',
                            style: TextStyle(
                              fontFamily: 'NunitoSans-Bold',
                              fontSize: width * (34 / 1920),
                              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                            ),
                          ),
                        ),
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

  Widget _distributionChart(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final values =
        _distributionData[_selectedDepartment] ?? _distributionData['All']!;

    return BarChart(
      BarChartData(
        maxY: 25,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            axisNameWidget: Text(
              'Employee Count',
              style: TextStyle(
                fontFamily: 'NunitoSans-Regular',
                fontSize: width * (12 / 1920),
                color: getPrimaryTextColor(themeProvider.isDarkMode),
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (34 / 1920),
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (13 / 1920),
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
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
                final labels = ['Excellent', 'Good', 'Poor'];
                final index = value.toInt();
                final text = index >= 0 && index < labels.length
                    ? labels[index]
                    : '';

                return Padding(
                  padding: EdgeInsets.only(top: width * (8 / 1920)),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (14 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          _bar(width, 0, values[0], Colors.green),
          _bar(width, 1, values[1], Colors.orange),
          _bar(width, 2, values[2], Colors.redAccent),
        ],
      ),
    );
  }

  Widget _departmentFilter(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: width * (32 / 1920),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _departments.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: width * (8 / 1920)),
        itemBuilder: (context, index) {
          final department = _departments[index];
          final isSelected = department == _selectedDepartment;

          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: isSelected
                  ? themeProvider.isDarkMode ? darkSecondaryColor : const Color(0xFF8FB2E3)
                  : Colors.white.withValues(alpha: 0.38),
              padding: EdgeInsets.symmetric(horizontal: width * (14 / 1920)),
              minimumSize: Size(0, width * (32 / 1920)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * (9 / 1920)),
              ),
            ),
            onPressed: () => setState(() => _selectedDepartment = department),
            child: Text(
              department,
              style: TextStyle(
                fontFamily: isSelected
                    ? 'NunitoSans-Bold'
                    : 'NunitoSans-Regular',
                fontSize: width * (13 / 1920),
                color: getPrimaryTextColor(themeProvider.isDarkMode),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _topCard(
    double width,
    String title,
    String number,
    IconData icon,
    Color color,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: width * (340 / 1920),
      height: width * (120 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
        borderRadius: BorderRadius.circular(width * (18 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: themeProvider.isDarkMode ? Colors.black54 : Colors.black12,
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
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
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

  BarChartGroupData _bar(double width, int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: width * (42 / 1920),
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
      ],
    );
  }
}
