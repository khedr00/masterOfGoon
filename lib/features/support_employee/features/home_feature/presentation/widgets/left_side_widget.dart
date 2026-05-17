import 'package:flutter/material.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/body_left_side_widget.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_app_bar.dart';

class LeftSideWidget extends StatelessWidget {
  const LeftSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: width * 0.02,
        horizontal: width * 0.03,
      ),
      child: Column(children: [CustomAppBar(), BodyLeftSideWidget()]),
    );
  }
}
