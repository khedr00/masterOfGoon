import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class LeadDashboardPage extends StatelessWidget {
  const LeadDashboardPage({super.key, required this.onBack});

  final VoidCallback onBack;

  static const _segments = [
    _LeadSegment('Casual Browsers', 48.1, Color(0xFF7EC3F4)),
    _LeadSegment('Hot Buyers', 27.4, Color(0xFF1476C9)),
    _LeadSegment('Serious Buyers', 24.5, Color(0xFFFFA1A8)),
  ];

  static const _priorityLeads = [
    _PriorityLead('8', '0.9695', '0.97', '0.9727'),
    _PriorityLead('657', '0.9552', '0.94', '0.9551'),
    _PriorityLead('748', '0.9163', '0.93', '0.9288'),
    _PriorityLead('2369', '0.9204', '0.92', '0.9283'),
    _PriorityLead('477', '0.8797', '0.98', '0.9218'),
    _PriorityLead('2405', '0.9147', '0.89', '0.9158'),
    _PriorityLead('2407', '0.9457', '0.82', '0.9134'),
    _PriorityLead('2355', '0.8731', '0.94', '0.9059'),
    _PriorityLead('1587', '0.8827', '0.92', '0.9056'),
    _PriorityLead('2', '0.8603', '0.93', '0.8952'),
  ];

  static const _revenueLeads = [
    _RevenueLead('1586', '786255.13', '0.9731', '765129.772'),
    _RevenueLead('8', '726743.69', '0.9695', '704590.0839'),
    _RevenueLead('1578', '703842.59', '0.9639', '678401.0633'),
    _RevenueLead('2369', '720018.09', '0.9204', '662723.0924'),
    _RevenueLead('1587', '687343.22', '0.8827', '606721.3462'),
    _RevenueLead('2407', '594822.58', '0.9457', '562520.9613'),
    _RevenueLead('188', '593191.89', '0.9452', '560657.9769'),
    _RevenueLead('2234', '609582.02', '0.9166', '558744.0998'),
    _RevenueLead('3069', '592935.95', '0.8878', '526407.7396'),
    _RevenueLead('1036', '586877.21', '0.8882', '521277.8251'),
  ];

  static const _forecastRows = [
    _ForecastRow(
      '2026-04-01 00:00:00',
      '1690',
      '0.7277',
      '1229',
      '253532577.1484',
    ),
    _ForecastRow(
      '2026-05-01 00:00:00',
      '2043',
      '0.75',
      '1532',
      '316038981.4413',
    ),
    _ForecastRow(
      '2026-06-01 00:00:00',
      '2396',
      '0.75',
      '1797',
      '370706298.7272',
    ),
    _ForecastRow(
      '2026-07-01 00:00:00',
      '2748',
      '0.75',
      '2061',
      '425167324.2497',
    ),
    _ForecastRow(
      '2026-08-01 00:00:00',
      '3101',
      '0.75',
      '2325',
      '479628349.7722',
    ),
    _ForecastRow(
      '2026-09-01 00:00:00',
      '3454',
      '0.75',
      '2590',
      '534295667.0581',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Provider.of<ThemeProvider>(context);

    return Container(
      color: theme.isDarkMode ? darkBackGroundColor : backGroundColor,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          width * (40 / 1920),
          width * (24 / 1920),
          width * (40 / 1920),
          width * (36 / 1920),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Lead Dashboard',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (32 / 1920),
                    color: getPrimaryTextColor(theme.isDarkMode),
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: theme.isDarkMode
                        ? darkCardColor
                        : const Color(0xFFDCE7F8),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * (18 / 1920),
                      vertical: width * (10 / 1920),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * (10 / 1920)),
                    ),
                  ),
                  onPressed: onBack,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: theme.isDarkMode ? darkPrimaryColor : primaryColor,
                    size: width * (20 / 1920),
                  ),
                  label: Text(
                    'Back to Dashboard',
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (15 / 1920),
                      color: theme.isDarkMode ? darkPrimaryColor : primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width * (20 / 1920)),
            _metricAndSegments(width, theme),
            SizedBox(height: width * (24 / 1920)),
            _dataTable(
              width,
              theme,
              title: 'Top Priority Leads',
              columns: const [
                'lead_id',
                'conversion_probability',
                'engagement_score',
                'priority_score',
              ],
              rows: [
                for (final lead in _priorityLeads)
                  [
                    lead.leadId,
                    lead.conversionProbability,
                    lead.engagementScore,
                    lead.priorityScore,
                  ],
              ],
            ),
            SizedBox(height: width * (24 / 1920)),
            _dataTable(
              width,
              theme,
              title: 'Top Revenue Opportunities',
              columns: const [
                'lead_id',
                'budget',
                'conversion_probability',
                'expected_revenue',
              ],
              rows: [
                for (final lead in _revenueLeads)
                  [
                    lead.leadId,
                    lead.budget,
                    lead.conversionProbability,
                    lead.expectedRevenue,
                  ],
              ],
            ),
            SizedBox(height: width * (24 / 1920)),
            _forecastChart(width, theme),
            SizedBox(height: width * (24 / 1920)),
            _dataTable(
              width,
              theme,
              title: 'Forecast Data',
              columns: const [
                'month',
                'predicted_leads',
                'predicted_conversion_rate',
                'predicted_conversions',
                'predicted_revenue',
              ],
              rows: [
                for (final row in _forecastRows)
                  [
                    row.month,
                    row.predictedLeads,
                    row.predictedConversionRate,
                    row.predictedConversions,
                    row.predictedRevenue,
                  ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metricAndSegments(double width, ThemeProvider theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width * (350 / 1920),
          height: width * (150 / 1920),
          decoration: _panelDecoration(width, theme),
          padding: EdgeInsets.symmetric(
            horizontal: width * (24 / 1920),
            vertical: width * (18 / 1920),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Leads',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Regular',
                  fontSize: width * (18 / 1920),
                  color: getPrimaryTextColor(theme.isDarkMode),
                ),
              ),
              Text(
                '3,234',
                style: TextStyle(
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (44 / 1920),
                  color: theme.isDarkMode ? darkPrimaryColor : primaryColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: width * (24 / 1920)),
        Expanded(
          child: Container(
            height: width * (360 / 1920),
            decoration: _panelDecoration(width, theme),
            padding: EdgeInsets.all(width * (24 / 1920)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customer Segmentation',
                  style: _sectionTitleStyle(width, theme),
                ),
                SizedBox(height: width * (16 / 1920)),
                Text(
                  'Lead Segments Distribution',
                  style: _subtitleStyle(width, theme),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 0,
                            centerSpaceRadius: 0,
                            sections: [
                              for (final segment in _segments)
                                PieChartSectionData(
                                  color: segment.color,
                                  value: segment.percent,
                                  title: '${segment.percent}%',
                                  radius: width * (105 / 1920),
                                  titleStyle: TextStyle(
                                    fontFamily: 'NunitoSans-Bold',
                                    fontSize: width * (13 / 1920),
                                    color: theme.isDarkMode
                                        ? darkBackGroundColor
                                        : lightPrimaryTextColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: width * (22 / 1920)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final segment in _segments)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: width * (10 / 1920),
                              ),
                              child: _legend(width, theme, segment),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _forecastChart(double width, ThemeProvider theme) {
    const months = [
      'Apr 2026',
      'May 2026',
      'Jun 2026',
      'Jul 2026',
      'Aug 2026',
      'Sep 2026',
    ];
    const values = [1229.0, 1532.0, 1797.0, 2061.0, 2325.0, 2590.0];

    return Container(
      height: width * (430 / 1920),
      decoration: _panelDecoration(width, theme),
      padding: EdgeInsets.fromLTRB(
        width * (22 / 1920),
        width * (18 / 1920),
        width * (24 / 1920),
        width * (18 / 1920),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Predicted Conversions',
            style: _sectionTitleStyle(width, theme),
          ),
          SizedBox(height: width * (14 / 1920)),
          Expanded(
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 5,
                minY: 1100,
                maxY: 2700,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 500,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: getDividerColor(theme.isDarkMode),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      'predicted_conversions',
                      style: _axisStyle(width, theme),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: width * (55 / 1920),
                      interval: 500,
                      getTitlesWidget: (value, meta) {
                        if (value != 1500 && value != 2000 && value != 2500) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          value.toInt().toString(),
                          style: _axisStyle(width, theme),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      'month',
                      style: _axisStyle(width, theme),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: width * (45 / 1920),
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= months.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: width * (10 / 1920)),
                          child: Text(
                            months[index],
                            style: _axisStyle(width, theme),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < values.length; i++)
                        FlSpot(i.toDouble(), values[i]),
                    ],
                    isCurved: false,
                    color: const Color(0xFF7EC3F4),
                    barWidth: width * (3 / 1920),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: width * (4 / 1920),
                            color: const Color(0xFF7EC3F4),
                            strokeWidth: 0,
                          ),
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataTable(
    double width,
    ThemeProvider theme, {
    required String title,
    required List<String> columns,
    required List<List<String>> rows,
  }) {
    return Container(
      width: double.infinity,
      decoration: _panelDecoration(width, theme),
      padding: EdgeInsets.all(width * (18 / 1920)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _sectionTitleStyle(width, theme)),
          SizedBox(height: width * (14 / 1920)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStatePropertyAll(
                theme.isDarkMode ? darkCardColor : const Color(0xFFE8EEF9),
              ),
              dataRowColor: WidgetStatePropertyAll(
                theme.isDarkMode ? darkBackGroundColor : Colors.white,
              ),
              border: TableBorder.all(
                color: getDividerColor(theme.isDarkMode),
                width: 1,
                borderRadius: BorderRadius.circular(width * (8 / 1920)),
              ),
              headingTextStyle: TextStyle(
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (14 / 1920),
                color: getSecondaryTextColor(theme.isDarkMode),
              ),
              dataTextStyle: TextStyle(
                fontFamily: 'NunitoSans-SemiBold',
                fontSize: width * (14 / 1920),
                color: getPrimaryTextColor(theme.isDarkMode),
              ),
              columnSpacing: width * (64 / 1920),
              columns: [
                for (final column in columns) DataColumn(label: Text(column)),
              ],
              rows: [
                for (final row in rows)
                  DataRow(
                    cells: [for (final value in row) DataCell(Text(value))],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legend(double width, ThemeProvider theme, _LeadSegment segment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width * (12 / 1920),
          height: width * (12 / 1920),
          decoration: BoxDecoration(color: segment.color),
        ),
        SizedBox(width: width * (8 / 1920)),
        Text(
          segment.name,
          style: TextStyle(
            fontFamily: 'NunitoSans-Regular',
            fontSize: width * (14 / 1920),
            color: getPrimaryTextColor(theme.isDarkMode),
          ),
        ),
      ],
    );
  }

  BoxDecoration _panelDecoration(double width, ThemeProvider theme) {
    return BoxDecoration(
      color: theme.isDarkMode ? darkBackGroundColor : const Color(0xFFDCE7F8),
      borderRadius: BorderRadius.circular(width * (18 / 1920)),
      border: Border.all(color: getDividerColor(theme.isDarkMode), width: 1),
      boxShadow: [
        BoxShadow(
          blurRadius: width * (8 / 1920),
          color: theme.isDarkMode ? Colors.black54 : Colors.black12,
          offset: Offset(0, width * (3 / 1920)),
        ),
      ],
    );
  }

  TextStyle _sectionTitleStyle(double width, ThemeProvider theme) => TextStyle(
    fontFamily: 'NunitoSans-Bold',
    fontSize: width * (24 / 1920),
    color: getPrimaryTextColor(theme.isDarkMode),
  );

  TextStyle _subtitleStyle(double width, ThemeProvider theme) => TextStyle(
    fontFamily: 'NunitoSans-Bold',
    fontSize: width * (16 / 1920),
    color: getPrimaryTextColor(theme.isDarkMode),
  );

  TextStyle _axisStyle(double width, ThemeProvider theme) => TextStyle(
    fontFamily: 'NunitoSans-Regular',
    fontSize: width * (12 / 1920),
    color: getPrimaryTextColor(theme.isDarkMode),
  );
}

class _LeadSegment {
  const _LeadSegment(this.name, this.percent, this.color);

  final String name;
  final double percent;
  final Color color;
}

class _PriorityLead {
  const _PriorityLead(
    this.leadId,
    this.conversionProbability,
    this.engagementScore,
    this.priorityScore,
  );

  final String leadId;
  final String conversionProbability;
  final String engagementScore;
  final String priorityScore;
}

class _RevenueLead {
  const _RevenueLead(
    this.leadId,
    this.budget,
    this.conversionProbability,
    this.expectedRevenue,
  );

  final String leadId;
  final String budget;
  final String conversionProbability;
  final String expectedRevenue;
}

class _ForecastRow {
  const _ForecastRow(
    this.month,
    this.predictedLeads,
    this.predictedConversionRate,
    this.predictedConversions,
    this.predictedRevenue,
  );

  final String month;
  final String predictedLeads;
  final String predictedConversionRate;
  final String predictedConversions;
  final String predictedRevenue;
}
