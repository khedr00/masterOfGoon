import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/models/dashboard_data.dart';
import 'package:untitled1/providers/theme_provider.dart';

class FirstSection extends StatefulWidget {
  const FirstSection({super.key, this.data});
  final DealDashboardData? data;

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  static const List<String> _regions = [
    'All',
    'Damascus',
    'Aleppo',
    'Homs',
    'Hama',
    'Tartous',
  ];

  static const Map<String, List<List<double>>> _dealChartData = {
    'All': [
      [36, 29, 23],
      [24, 30, 10],
      [24, 11, 15],
      [37, 26, 15],
      [19, 13, 8],
    ],
    'Damascus': [
      [18, 15, 8],
      [12, 14, 4],
      [10, 6, 5],
      [17, 13, 6],
      [8, 5, 3],
    ],
    'Aleppo': [
      [8, 6, 5],
      [5, 7, 2],
      [6, 2, 4],
      [8, 5, 4],
      [4, 3, 2],
    ],
    'Homs': [
      [5, 4, 4],
      [4, 4, 2],
      [3, 1, 2],
      [5, 3, 2],
      [3, 2, 1],
    ],
    'Hama': [
      [3, 2, 3],
      [2, 3, 1],
      [3, 1, 2],
      [4, 3, 2],
      [2, 1, 1],
    ],
    'Tartous': [
      [2, 2, 3],
      [1, 2, 1],
      [2, 1, 2],
      [3, 2, 1],
      [2, 2, 1],
    ],
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
        width: width * (1032 / 1920),
        padding: EdgeInsets.all(width * (18 / 1920)),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : const Color(0xFF8FB0E0),
          borderRadius: BorderRadius.circular(width * (18 / 1920)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _topCard(
                  width,
                  title: 'Open Deals',
                  value: '${widget.data?.open ?? 25}',
                  valueColor: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF136B8A),
                ),
                _topCard(
                  width,
                  title: 'Successful Deals:',
                  value: '${widget.data?.successful ?? 10}',
                  valueColor: Colors.green,
                ),
                _topCard(
                  width,
                  title: 'Lost Deals:',
                  value: '${widget.data?.failed ?? 7}',
                  valueColor: Colors.red.shade900,
                ),
                _topCard(
                  width,
                  title: 'Deal Success Rate',
                  value: '${widget.data?.successRate.toStringAsFixed(0) ?? '70'}%',
                  valueColor: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF136B8A),
                ),
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
    );
  }

  Widget _expandedContent(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      key: const ValueKey('deals-expanded'),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _regionFilter(width),
                SizedBox(height: width * (10 / 1920)),
                Container(
                  width: width * (560 / 1920),
                  height: width * (270 / 1920),
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
                  child: _dealsBarChart(width),
                ),
              ],
            ),
            SizedBox(width: width * (24 / 1920)),
            Container(
              width: width * (360 / 1920),
              height: width * (320 / 1920),
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
                  SizedBox(
                    width: width * (210 / 1920),
                    height: width * (210 / 1920),
                    child: PieChart(
                      PieChartData(
                        centerSpaceRadius: width * (55 / 1920),
                        sectionsSpace: 0,
                        sections: [
                          _pieSection(width, Colors.redAccent, 14, '14'),
                          _pieSection(width, Colors.pinkAccent, 5, '5'),
                          _pieSection(width, Colors.green, 3, '3'),
                          _pieSection(width, Colors.lightBlue, 7, '7'),
                          _pieSection(width, Colors.purple, 6, '6'),
                        ],
                      ),
                    ),
                  ),
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
        SizedBox(height: width * (18 / 1920)),
        Divider(thickness: width * (1 / 1920), color: getDividerColor(themeProvider.isDarkMode)),
        SizedBox(height: width * (12 / 1920)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _smallPie(width, title: 'Open Deals:', value: '25'),
            _smallPie(width, title: 'Successful Deals:', value: '10'),
            _smallPie(width, title: 'Lost Deals:', value: '7'),
          ],
        ),
      ],
    );
  }

  Widget _dealsBarChart(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final data = _dealChartData[_selectedRegion] ?? _dealChartData['All']!;

    return BarChart(
      BarChartData(
        maxY: 45,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (32 / 1920),
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: EdgeInsets.only(right: width * (8 / 1920)),
                  child: Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (13 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (40 / 1920),
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
                  padding: EdgeInsets.only(top: width * (10 / 1920)),
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
        barGroups: List.generate(data.length, (index) {
          final values = data[index];
          return BarChartGroupData(
            x: index,
            barsSpace: width * (4 / 1920),
            barRods: [
              BarChartRodData(
                toY: values[0],
                width: width * (14 / 1920),
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF17769E),
              ),
              BarChartRodData(
                toY: values[1],
                width: width * (14 / 1920),
                borderRadius: BorderRadius.circular(8),
                color: Colors.green,
              ),
              BarChartRodData(
                toY: values[2],
                width: width * (14 / 1920),
                borderRadius: BorderRadius.circular(8),
                color: Colors.red.shade700,
              ),
            ],
          );
        }),
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
            color: themeProvider.isDarkMode ? darkPrimaryColor : const Color(0xFF136B8A),
          ),
        ),
      ),
    );
  }

  Widget _regionFilter(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: width * (560 / 1920),
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
    double width, {
    required String title,
    required String value,
    required Color valueColor,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: width * (190 / 1920),
      height: width * (98 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkBackGroundColor : const Color(0xFFD9E4F7),
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (8 / 1920),
            color: themeProvider.isDarkMode ? Colors.black54 : Colors.black12,
            offset: Offset(0, width * (4 / 1920)),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'NunitoSans-Regular',
              fontSize: width * (16 / 1920),
              color: getPrimaryTextColor(themeProvider.isDarkMode),
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

  Widget _smallPie(
    double width, {
    required String title,
    required String value,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (20 / 1920),
            color: getPrimaryTextColor(themeProvider.isDarkMode),
          ),
        ),
        SizedBox(height: width * (8 / 1920)),
        SizedBox(
          width: width * (190 / 1920),
          height: width * (190 / 1920),
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  centerSpaceRadius: width * (45 / 1920),
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(
                      value: 8,
                      color: Colors.green,
                      radius: width * (42 / 1920),
                      title: '',
                    ),
                    PieChartSectionData(
                      value: 7,
                      color: Colors.lightBlue,
                      radius: width * (42 / 1920),
                      title: '',
                    ),
                    PieChartSectionData(
                      value: 5,
                      color: Colors.orange,
                      radius: width * (42 / 1920),
                      title: '',
                    ),
                    PieChartSectionData(
                      value: 5,
                      color: Colors.purple,
                      radius: width * (42 / 1920),
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
                      fontSize: width * (34 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                  Text(
                    'deals',
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (14 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: width * (6 / 1920)),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: width * (10 / 1920),
          runSpacing: width * (4 / 1920),
          children: [
            _buildRegion(width, Colors.green, 'Rent'),
            _buildRegion(width, Colors.lightBlue, 'Sold'),
            _buildRegion(width, Colors.orange, 'Purchase'),
            _buildRegion(width, Colors.purple, 'Lease'),
          ],
        ),
      ],
    );
  }

  PieChartSectionData _pieSection(
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
        fontSize: width * (18 / 1920),
      ),
    );
  }
}

Widget _buildRegion(double width, Color color, String text) {
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
              fontSize: width * (14 / 1920),
              color: getPrimaryTextColor(themeProvider.isDarkMode),
            ),
          ),
        ],
      );
    },
  );
}
