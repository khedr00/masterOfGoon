import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/app_bar_component.dart';
import 'package:untitled1/core/widgets/app_bar_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/internal_chat_button.dart';
import 'package:untitled1/core/widgets/page_header.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Column(
        children: [
          PageHeader(),
          Container(
            width: width * (60 / 1920),
            height: width * (60 / 1920),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
