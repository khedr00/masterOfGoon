import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/core/widgets/app_image.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryColor,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
        color: primaryColor,
        borderRadius: BorderRadius.circular(width * 0.01),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: AppImage(path: image, width: width * 0.03, height: width * 0.03),
      ),
    );
  }
}
