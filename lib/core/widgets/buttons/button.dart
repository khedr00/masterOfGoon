import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.child,
    required this.buttonAction,
    required this.widthOfButton,
    required this.heightOfButton,
    required this.borderRadiusOfButton,
  });
  final Widget child;
  final GestureTapCallback? buttonAction;
  final double widthOfButton;
  final double heightOfButton;
  final double borderRadiusOfButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        width: widthOfButton,
        height: heightOfButton,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(borderRadiusOfButton),
          boxShadow: [
            BoxShadow(
              color: primaryColor,
              blurRadius: 20,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
