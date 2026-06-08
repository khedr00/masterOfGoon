import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertiesDashboardWidget extends StatefulWidget {
  const PropertiesDashboardWidget({super.key});

  @override
  State<PropertiesDashboardWidget> createState() =>
      _PropertiesDashboardWidgetState();
}

class _PropertiesDashboardWidgetState extends State<PropertiesDashboardWidget> {
  static const List<String> _regions = [
    'All',
    'Damascus',
    'Aleppo',
    'Homs',
    'Tartous',
  ];

  static const Map<String, List<double>> _propertyChartData = {
    'All': [32, 24, 17, 12, 8],
    'Damascus': [14, 11, 8, 6, 4],
    'Aleppo': [7, 5, 4, 3, 2],
    'Homs': [5, 4, 3, 2, 1],
    'Tartous': [6, 4, 2, 1, 1],
  };

  bool _expanded = false;
  String _selectedRegion = 'All';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: width * (835 / 1920),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : const Color(0xFF8FB2E3),
          borderRadius: BorderRadius.circular(width * (22 / 1920)),
        ),
        child: Padding(
          padding: EdgeInsets.all(width * (20 / 1920)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topCard(
                    width,
                    'Total Properties',
                    '124',
                    Icons.home_work_rounded,
                    themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF1C769B),
                  ),
                  _topCard(
                    width,
                    'Available',
                    '88',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _topCard(
                    width,
                    'For Sale',
                    '21',
                    Icons.sell,
                    Colors.redAccent,
                  ),
                  _topCard(width, 'For Rent', '15', Icons.key, Colors.orange),
                ],
              ),
              SizedBox(height: width * (18 / 1920)),
              _toggleButton(width),
              if (_expanded) ...[
                SizedBox(height: width * (8 / 1920)),
                _expandedContent(width),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _expandedContent(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      key: const ValueKey('properties-expanded'),
      children: [
        _regionFilter(width),
        SizedBox(height: width * (10 / 1920)),
        Container(
          width: double.infinity,
          height: width * (300 / 1920),
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
                'Properties Types',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (22 / 1920),
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),
              Expanded(child: _propertyBarChart(width)),
            ],
          ),
        ),
        SizedBox(height: width * (18 / 1920)),
        Container(
          width: double.infinity,
          height: width * (300 / 1920),
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
                'Regions',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (22 / 1920),
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),
              SizedBox(
                width: width * (210 / 1920),
                height: width * (210 / 1920),
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: width * (52 / 1920),
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
                spacing: width * (14 / 1920),
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
    );
  }

  Widget _propertyBarChart(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final values =
        _propertyChartData[_selectedRegion] ?? _propertyChartData['All']!;

    return BarChart(
      BarChartData(
        maxY: 40,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
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
                final labels = [
                  'Apartment',
                  'House',
                  'Villa',
                  'Office',
                  'Hall',
                ];
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
                      fontSize: width * (12 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: List.generate(
          values.length,
          (index) => _bar(width, index, values[index]),
        ),
      ),
    );
  }

  Widget _toggleButton(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
          padding: EdgeInsets.symmetric(
            horizontal: width * (18 / 1920),
            vertical: width * (8 / 1920),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * (10 / 1920)),
          ),
        ),
        onPressed: () => setState(() => _expanded = !_expanded),
        child: Text(
          _expanded ? 'Show Less' : 'Show More',
          style: TextStyle(
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (14 / 1920),
            color: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF1C769B),
          ),
        ),
      ),
    );
  }

  Widget _regionFilter(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: width * (30 / 1920),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _regions.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: width * (8 / 1920)),
        itemBuilder: (context, index) {
          final region = _regions[index];
          final isSelected = region == _selectedRegion;

          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: isSelected
                  ? themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8)
                  : Colors.white.withValues(alpha: 0.28),
              padding: EdgeInsets.symmetric(horizontal: width * (12 / 1920)),
              minimumSize: Size(0, width * (30 / 1920)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * (9 / 1920)),
              ),
            ),
            onPressed: () => setState(() => _selectedRegion = region),
            child: Text(
              region,
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
      width: width * (180 / 1920),
      height: width * (110 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
        borderRadius: BorderRadius.circular(width * (16 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: themeProvider.isDarkMode ? Colors.black54 : Colors.black12,
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
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
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

  BarChartGroupData _bar(double width, int x, double y) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: width * (24 / 1920),
          borderRadius: BorderRadius.circular(8),
          color: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF1C769B),
        ),
      ],
    );
  }

  PieChartSectionData _section(
    double width,
    Color color,
    double value,
    String title,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return PieChartSectionData(
      color: color,
      value: value,
      title: title,
      radius: width * (48 / 1920),
      titleStyle: TextStyle(
        color: getTextColor(themeProvider.isDarkMode),
        fontFamily: 'NunitoSans-Bold',
        fontSize: width * (16 / 1920),
      ),
    );
  }

  Widget _region(double width, Color color, String text) {
    return Builder(
      builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
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
                color: getPrimaryTextColor(themeProvider.isDarkMode),
              ),
            ),
          ],
        );
      },
    );
  }
}
