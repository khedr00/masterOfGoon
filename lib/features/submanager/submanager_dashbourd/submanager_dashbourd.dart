import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/data/dashboard_repository.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/models/dashboard_data.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/employees_dashboard_widget.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/first_section.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/properties_dashboard_widget.dart';

class SubmanagerDashbourd extends StatefulWidget {
  const SubmanagerDashbourd({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<SubmanagerDashbourd> createState() => _SubmanagerDashbourdState();
}

class _SubmanagerDashbourdState extends State<SubmanagerDashbourd> {
  late final DashboardRepository _repository;
  DashboardData? _dashboardData;
  DateTime? _from;
  DateTime? _to;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _repository = DashboardRepository(widget.userAuthInfo);
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    setState(() => _isLoading = true);
    try {
      final data = await _repository.getDashboard(from: _from, to: _to);
      if (mounted) setState(() => _dashboardData = data);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to load dashboard data.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDate({required bool isFrom}) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: isFrom
          ? (_from ?? _to ?? DateTime.now())
          : (_to ?? _from ?? DateTime.now()),
      firstDate: isFrom ? DateTime(2000) : (_from ?? DateTime(2000)),
      lastDate: isFrom ? (_to ?? DateTime.now()) : DateTime.now(),
    );
    if (selected == null) return;

    setState(() {
      if (isFrom) {
        _from = selected;
      } else {
        _to = selected;
      }
    });
    await _loadDashboard();
  }

  String _dateLabel(DateTime? value) => value == null
      ? 'Select date'
      : '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: width * (20 / 1920)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dateField(
                  width,
                  label: 'FROM',
                  value: _from,
                  onTap: () => _selectDate(isFrom: true),
                ),
                SizedBox(width: width * (16 / 1920)),
                _dateField(
                  width,
                  label: 'TO',
                  value: _to,
                  onTap: () => _selectDate(isFrom: false),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FirstSection(data: _dashboardData?.deals),
              PropertiesDashboardWidget(data: _dashboardData?.properties),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * (20 / 1920)),
            child: EmployeesDashboardWidget(data: _dashboardData?.employees),
          ),
        ],
      ),
    );
  }

  Widget _dateField(
    double width, {
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: _isLoading ? null : onTap,
    child: Container(
      width: width * (235 / 1920),
      height: width * (48 / 1920),
      padding: EdgeInsets.symmetric(
        horizontal: width * (14 / 1920),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(width * (8 / 1920)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ${_dateLabel(value)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (_isLoading) ...[
            SizedBox(width: width * (8 / 1920)),
            SizedBox(
              width: width * (14 / 1920),
              height: width * (14 / 1920),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ],
      ),
    ),
  );
}
