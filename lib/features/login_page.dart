import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: width * (1080 / 1920),
          child: Image.asset(
            'assets/images/backGround.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/Estate_hub.png', scale: 0.3),
            Container(
              width: width * (100 / 1920),
              height: width * (100 / 1920),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
                color: backGroundColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
