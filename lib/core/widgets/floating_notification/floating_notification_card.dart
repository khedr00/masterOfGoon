import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class FloatingNotificationCard extends StatelessWidget {
  const FloatingNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(width * (10 / 1920)),
      width: width * (200 / 1920),
      height: width * (70 / 1920),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * (20 / 1920)),
        color: secondaryColor,
      ),
      child: Text(
        textAlign: TextAlign.center,
        'new notification recieved',
        style: TextStyle(
          fontFamily: 'NunitoSans-Regular',
          fontSize: width * (18 / 1920),
        ),
      ),
    );
  }
}
