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
  static const _pieColors = [
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.green,
    Colors.lightBlue,
    Colors.purple,
    Colors.orange,
  ];
  bool _expanded = false;
  String _selectedRegion = 'All';

  List<String> get _regions => [
    'All',
    ..._cities(widget.data?.byCity ?? const []),
  ];

  @override
  void didUpdateWidget(covariant FirstSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_regions.contains(_selectedRegion)) _selectedRegion = 'All';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final data = widget.data;
    return AnimatedSize(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      clipBehavior: Clip.hardEdge,
      child: Container(
        width: width * (1032 / 1920),
        padding: EdgeInsets.all(width * (18 / 1920)),
        decoration: BoxDecoration(
          color: theme.isDarkMode
              ? darkSecondaryColor
              : const Color(0xFF8FB0E0),
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
                  value: '${data?.open ?? 0}',
                  valueColor: theme.isDarkMode
                      ? darkPrimaryColor
                      : const Color(0xFF136B8A),
                ),
                _topCard(
                  width,
                  title: 'Successful Deals:',
                  value: '${data?.successful ?? 0}',
                  valueColor: Colors.green,
                ),
                _topCard(
                  width,
                  title: 'Lost Deals:',
                  value: '${data?.failed ?? 0}',
                  valueColor: Colors.red.shade900,
                ),
                _topCard(
                  width,
                  title: 'Deal Success Rate',
                  value: '${data?.successRate.toStringAsFixed(0) ?? '0'}%',
                  valueColor: theme.isDarkMode
                      ? darkPrimaryColor
                      : const Color(0xFF136B8A),
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
    final theme = Provider.of<ThemeProvider>(context);
    final cities = _groupByCity(
      widget.data?.byCity ?? const <DashboardBreakdown>[],
    );
    final deals = widget.data;
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
                  decoration: _cardDecoration(width, theme),
                  child: _dealsBarChart(width),
                ),
              ],
            ),
            SizedBox(width: width * (24 / 1920)),
            Container(
              width: width * (360 / 1920),
              height: width * (320 / 1920),
              decoration: _cardDecoration(width, theme),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: width * (210 / 1920),
                    height: width * (210 / 1920),
                    child: cities.isEmpty
                        ? _noChartData(width)
                        : PieChart(
                            PieChartData(
                              centerSpaceRadius: width * (55 / 1920),
                              sectionsSpace: 0,
                              sections: _pieSections(width, cities),
                            ),
                          ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: width * (14 / 1920),
                    runSpacing: width * (10 / 1920),
                    children: [
                      for (var i = 0; i < cities.length; i++)
                        _legend(
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
        ),
        SizedBox(height: width * (18 / 1920)),
        Divider(
          thickness: width * (1 / 1920),
          color: getDividerColor(theme.isDarkMode),
        ),
        SizedBox(height: width * (12 / 1920)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statusPie(
              width,
              title: 'Open Deals:',
              value: deals?.open ?? 0,
              color: theme.isDarkMode
                  ? darkPrimaryColor
                  : const Color(0xFF136B8A),
            ),
            _statusPie(
              width,
              title: 'Successful Deals:',
              value: deals?.successful ?? 0,
              color: Colors.green,
            ),
            _statusPie(
              width,
              title: 'Lost Deals:',
              value: deals?.failed ?? 0,
              color: Colors.red.shade700,
            ),
          ],
        ),
      ],
    );
  }

  List<DashboardBreakdown> get _barData {
    final data = widget.data;
    if (data == null) return const [];
    final source = _selectedRegion == 'All'
        ? (data.byPropertyType.isNotEmpty
              ? data.byPropertyType
              : data.byDealType)
        : data.byCityAndPropertyType
              .where((item) => item.city == _selectedRegion)
              .toList();
    return _types(source, useDealType: source == data.byDealType);
  }

  Widget _dealsBarChart(double width) {
    final theme = Provider.of<ThemeProvider>(context);
    final data = _barData;
    final maxY = _chartMax(data.map((item) => item.count));
    if (data.isEmpty) return _noChartData(width);
    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
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
              reservedSize: width * (32 / 1920),
              interval: maxY / 4,
              getTitlesWidget: (value, meta) => Padding(
                padding: EdgeInsets.only(right: width * (8 / 1920)),
                child: Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (13 / 1920),
                    color: getPrimaryTextColor(theme.isDarkMode),
                  ),
                ),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: width * (40 / 1920),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                final label = index >= 0 && index < data.length
                    ? data[index].type ?? ''
                    : '';
                return Padding(
                  padding: EdgeInsets.only(top: width * (10 / 1920)),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (14 / 1920),
                      color: getPrimaryTextColor(theme.isDarkMode),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < data.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i].count.toDouble(),
                  width: width * (14 / 1920),
                  borderRadius: BorderRadius.circular(8),
                  color: theme.isDarkMode
                      ? darkPrimaryColor
                      : const Color(0xFF17769E),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _noChartData(double width) {
    final theme = Provider.of<ThemeProvider>(context);
    return Center(
      child: Text(
        'No chart data available',
        style: TextStyle(
          fontFamily: 'NunitoSans-Regular',
          fontSize: width * (16 / 1920),
          color: getPrimaryTextColor(theme.isDarkMode),
        ),
      ),
    );
  }

  Widget _toggleButton(double width) {
    final theme = Provider.of<ThemeProvider>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: theme.isDarkMode
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
            color: theme.isDarkMode
                ? darkPrimaryColor
                : const Color(0xFF136B8A),
          ),
        ),
      ),
    );
  }

  Widget _regionFilter(double width) {
    final theme = Provider.of<ThemeProvider>(context);
    final regions = _regions;
    return SizedBox(
      width: width * (560 / 1920),
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
                  ? theme.isDarkMode
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
                color: getPrimaryTextColor(theme.isDarkMode),
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
    final theme = Provider.of<ThemeProvider>(context);
    return Container(
      width: width * (190 / 1920),
      height: width * (98 / 1920),
      decoration: BoxDecoration(
        color: theme.isDarkMode ? darkBackGroundColor : const Color(0xFFD9E4F7),
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (8 / 1920),
            color: theme.isDarkMode ? Colors.black54 : Colors.black12,
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
              color: getPrimaryTextColor(theme.isDarkMode),
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

  Widget _statusPie(
    double width, {
    required String title,
    required int value,
    required Color color,
  }) {
    final theme = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (20 / 1920),
            color: getPrimaryTextColor(theme.isDarkMode),
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
                  sections: value == 0
                      ? const []
                      : [
                          PieChartSectionData(
                            value: value.toDouble(),
                            color: color,
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
                    '$value',
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (34 / 1920),
                      color: getPrimaryTextColor(theme.isDarkMode),
                    ),
                  ),
                  Text(
                    'deals',
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (14 / 1920),
                      color: getPrimaryTextColor(theme.isDarkMode),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            fontSize: width * (18 / 1920),
          ),
        ),
    ];
  }

  Widget _legend(double width, Color color, String text) {
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
            fontSize: width * (14 / 1920),
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
}

List<String> _cities(List<DashboardBreakdown> data) => {
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

List<DashboardBreakdown> _types(
  List<DashboardBreakdown> data, {
  bool useDealType = false,
}) {
  final counts = <String, int>{};
  for (final item in data) {
    final type = useDealType ? item.dealType : item.type;
    if (type != null && type.isNotEmpty) {
      counts[type] = (counts[type] ?? 0) + item.count;
    }
  }
  return [
    for (final entry in counts.entries)
      DashboardBreakdown(type: entry.key, count: entry.value),
  ];
}

double _chartMax(Iterable<int> values) {
  final maximum = values.fold<int>(
    0,
    (current, value) => value > current ? value : current,
  );
  return maximum == 0 ? 1 : maximum.toDouble();
}
