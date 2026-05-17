import 'package:flutter/material.dart';
import 'package:untitled1/features/support_employee/core/app_theme.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/left_side_widget.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/right_side_widget.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: backGroundColor,
        child: Row(children: [LeftSideWidget(), RightSideWidget()]),
      ),
    );
  }
}
