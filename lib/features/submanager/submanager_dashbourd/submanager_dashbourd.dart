import 'package:flutter/material.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/employees_dashboard_widget.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/first_section.dart';
import 'package:untitled1/features/submanager/submanager_dashbourd/widgets/properties_dashboard_widget.dart';

class SubmanagerDashbourd extends StatelessWidget {
  const SubmanagerDashbourd({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [FirstSection(), PropertiesDashboardWidget()],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * (20 / 1920)),
            child: EmployeesDashboardWidget(),
          ),
        ],
      ),
    );
  }
}
