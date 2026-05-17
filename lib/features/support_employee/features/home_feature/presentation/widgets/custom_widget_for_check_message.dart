import 'package:flutter/material.dart';

class CustomWidgetForCheckMessage extends StatelessWidget {
  const CustomWidgetForCheckMessage({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: width * 0.012,
        height: width * 0.025,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(width * 0.005),
        ),
      ),
    );
  }
}
