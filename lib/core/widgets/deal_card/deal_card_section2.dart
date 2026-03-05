import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardSection2 extends StatelessWidget {
  const DealCardSection2({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (331 / 1920),
      height: width * (194 / 1920),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: width * (9 / 1920),
          left: width * (9 / 1920),
          right: width * (9 / 1920),
        ),
        child: Container(
          width: width * (331 / 1920),
          height: width * (194 / 1920),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
