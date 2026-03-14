import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class MultiTabTabableCardHeader extends StatelessWidget {
  const MultiTabTabableCardHeader({
    super.key,
    required this.tabName,
    required this.isTabed,
    required this.color,
    required this.index,
  });
  final String tabName;
  final ThemeColor color;
  final bool isTabed;
  final int index;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (index == 0) {
      return Container(
        height: width * (52 / 1920),
        width: width * (179 / 1920),
        decoration: BoxDecoration(
          color: color.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * (10 / 1920)),
            topRight: Radius.circular(width * (10 / 1920)),
            bottomRight: Radius.circular(width * (30 / 1920)),
          ),
        ),
        child: Center(
          child: Text(
            tabName,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'NunitoSans-Bold',
              fontSize: width * (20 / 1920),
            ),
          ),
        ),
      );
    }
    return Container(
      height: width * (52 / 1920),
      width: width * (207 / 1920),
      decoration: BoxDecoration(
        color: color.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (30 / 1920)),
          bottomRight: Radius.circular(width * (30 / 1920)),
          topLeft: Radius.circular(width * (10 / 1920)),
          topRight: Radius.circular(width * (10 / 1920)),
        ),
      ),
      child: Center(
        child: Text(
          tabName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (20 / 1920),
          ),
        ),
      ),
    );
  }
}
