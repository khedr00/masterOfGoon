// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/custom_widget_for_check_message.dart';

class CustomContainerForComplaint extends StatelessWidget {
  const CustomContainerForComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: secondaryColor),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'I would like to report an issue regarding one of your employees. During my visit, the staff member was rude, interrupted me several times, and did not provide proper assistance. I was disappointed with the service and expected more professional',
                ),
              ),
            ),
          ),
          Column(
            children: [
              CustomWidgetForCheckMessage(color: backGroundColor),
              CustomWidgetForCheckMessage(color: primaryColor),
            ],
          ),
        ],
      ),
    );
  }
}
