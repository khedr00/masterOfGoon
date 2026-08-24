import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/models/dashboard_data.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PropertiesDashboardWidget extends StatefulWidget {
  const PropertiesDashboardWidget({super.key, this.data});
  final PropertyDashboardData? data;

  @override
  State<PropertiesDashboardWidget> createState() =>
      _PropertiesDashboardWidgetState();
}

class _PropertiesDashboardWidgetState extends State<PropertiesDashboardWidget> {
  static const _pieColors = [
    Colors.redAccent,
    Colors.lightBlue,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];
  bool _expanded = false;
  String _selectedRegion = 'All';

  List<String> get _regions => [
    'All',
    ..._uniqueCities(widget.data?.byCity ?? const []),
  ];

  @override
  void didUpdateWidget(covariant PropertiesDashboardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_regions.contains(_selectedRegion)) _selectedRegion = 'All';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final data = widget.data;
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: width * (835 / 1920),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? darkSecondaryColor
              : const Color(0xFF8FB2E3),
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
                    '${data?.total ?? 0}',
                    Icons.home_work_rounded,
                    themeProvider.isDarkMode
                        ? darkPrimaryColor
                        : const Color(0xFF1C769B),
                  ),
                  _topCard(
                    width,
                    'Available',
                    '${data?.available ?? 0}',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  _topCard(
                    width,
                    'For Sale',
                    '${data?.forSale ?? 0}',
                    Icons.sell,
                    Colors.redAccent,
                  ),
                  _topCard(
                    width,
                    'For Rent',
                    '${data?.forLease ?? 0}',
                    Icons.key,
                    Colors.orange,
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
      ),
    );
  }

  Widget _expandedContent(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final cities = _groupByCity(
      widget.data?.byCity ?? const <DashboardBreakdown>[],
    );
    return Column(
      key: const ValueKey('properties-expanded'),
      children: [
        _regionFilter(width),
        SizedBox(height: width * (10 / 1920)),
        Container(
          width: double.infinity,
          height: width * (300 / 1920),
          padding: EdgeInsets.all(width * (18 / 1920)),
          decoration: _cardDecoration(width, themeProvider),
          child: Column(
            children: [
              Text(
                'Properties Types',
                style: _titleStyle(width, themeProvider),
              ),
              Expanded(child: _propertyBarChart(width)),
            ],
          ),
        ),
        SizedBox(height: width * (18 / 1920)),
        Container(
          width: double.infinity,
          height: width * (300 / 1920),
          decoration: _cardDecoration(width, themeProvider),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Regions', style: _titleStyle(width, themeProvider)),
              SizedBox(
                width: width * (210 / 1920),
                height: width * (210 / 1920),
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: width * (52 / 1920),
                    sectionsSpace: 0,
                    sections: _pieSections(width, cities),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: width * (14 / 1920),
                runSpacing: width * (8 / 1920),
                children: [
                  for (var i = 0; i < cities.length; i++)
                    _region(
                      width,
                      _pieColors[i % _pieColors.length],
                      cities[i].city ?? '',
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<DashboardBreakdown> get _barData {
    final data = widget.data;
    if (data == null) return const [];
    final source = _selectedRegion == 'All'
        ? data.byType
        : data.byTypeAndCity
              .where((item) => item.city == _selectedRegion)
              .toList();
    return _groupByType(source);
  }

  Widget _propertyBarChart(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final data = _barData;
    final maxY = _maxY(data.map((item) => item.count));
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (28 / 1920),
              interval: maxY / 4,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: TextStyle(
                  fontFamily: 'NunitoSans-Regular',
                  fontSize: width * (12 / 1920),
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (34 / 1920),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                final label = index >= 0 && index < data.length
                    ? data[index].type ?? ''
                    : '';
                return Padding(
                  padding: EdgeInsets.only(top: width * (8 / 1920)),
                  child: Text(
                    label,
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
        barGroups: [
          for (var i = 0; i < data.length; i++)
            _bar(width, i, data[i].count.toDouble()),
        ],
      ),
    );
  }

  Widget _toggleButton(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: themeProvider.isDarkMode
              ? darkBackGroundColor
              : const Color(0xFFDCE7F8),
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
            color: themeProvider.isDarkMode
                ? darkPrimaryColor
                : const Color(0xFF1C769B),
          ),
        ),
      ),
    );
  }

  Widget _regionFilter(double width) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final regions = _regions;
    return SizedBox(
      width: double.infinity,
      height: width * (30 / 1920),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: regions.length,
        separatorBuilder: (_, _) => SizedBox(width: width * (8 / 1920)),
        itemBuilder: (context, index) {
          final region = regions[index];
          final selected = region == _selectedRegion;
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: selected
                  ? themeProvider.isDarkMode
                        ? darkBackGroundColor
                        : const Color(0xFFDCE7F8)
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
                fontFamily: selected ? 'NunitoSans-Bold' : 'NunitoSans-Regular',
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
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      width: width * (180 / 1920),
      height: width * (110 / 1920),
      decoration: BoxDecoration(
        color: theme.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
        borderRadius: BorderRadius.circular(width * (16 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (6 / 1920),
            color: theme.isDarkMode ? Colors.black54 : Colors.black12,
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
                      color: getPrimaryTextColor(theme.isDarkMode),
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
    final theme = Provider.of<ThemeProvider>(context);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: width * (24 / 1920),
          borderRadius: BorderRadius.circular(8),
          color: theme.isDarkMode ? darkPrimaryColor : const Color(0xFF1C769B),
        ),
      ],
    );
  }

  List<PieChartSectionData> _pieSections(
    double width,
    List<DashboardBreakdown> data,
  ) {
    final theme = Provider.of<ThemeProvider>(context);
    return [
      for (var i = 0; i < data.length; i++)
        PieChartSectionData(
          color: _pieColors[i % _pieColors.length],
          value: data[i].count.toDouble(),
          title: '${data[i].count}',
          radius: width * (48 / 1920),
          titleStyle: TextStyle(
            color: getTextColor(theme.isDarkMode),
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (16 / 1920),
          ),
        ),
    ];
  }

  Widget _region(double width, Color color, String text) {
    final theme = Provider.of<ThemeProvider>(context);
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
            color: getPrimaryTextColor(theme.isDarkMode),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration(double width, ThemeProvider theme) =>
      BoxDecoration(
        color: theme.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
        borderRadius: BorderRadius.circular(width * (18 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (8 / 1920),
            color: theme.isDarkMode ? Colors.black54 : Colors.black12,
            offset: Offset(0, width * (3 / 1920)),
          ),
        ],
      );
  TextStyle _titleStyle(double width, ThemeProvider theme) => TextStyle(
    fontFamily: 'NunitoSans-Bold',
    fontSize: width * (22 / 1920),
    color: getPrimaryTextColor(theme.isDarkMode),
  );
}

List<String> _uniqueCities(List<DashboardBreakdown> data) => {
  for (final item in data)
    if (item.city != null && item.city!.isNotEmpty) item.city!,
}.toList();
List<DashboardBreakdown> _groupByCity(List<DashboardBreakdown> data) {
  final counts = <String, int>{};
  for (final item in data) {
    final city = item.city;
    if (city != null && city.isNotEmpty) {
      counts[city] = (counts[city] ?? 0) + item.count;
    }
  }
  return [
    for (final entry in counts.entries)
      DashboardBreakdown(city: entry.key, count: entry.value),
  ];
}

List<DashboardBreakdown> _groupByType(List<DashboardBreakdown> data) {
  final counts = <String, int>{};
  for (final item in data) {
    final type = item.type;
    if (type != null && type.isNotEmpty) {
      counts[type] = (counts[type] ?? 0) + item.count;
    }
  }
  return [
    for (final entry in counts.entries)
      DashboardBreakdown(type: entry.key, count: entry.value),
  ];
}

double _maxY(Iterable<int> values) {
  final maximum = values.fold<int>(
    0,
    (current, value) => value > current ? value : current,
  );
  return maximum == 0 ? 1 : maximum.toDouble();
}
