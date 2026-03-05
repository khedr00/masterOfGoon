import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardSection1 extends StatelessWidget {
  const DealCardSection1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (136 / 1920),
      height: width * (52 / 1920),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: width * (9 / 1920)),
        child: Container(
          width: width * (136 / 1920),
          height: width * (43 / 1920),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
