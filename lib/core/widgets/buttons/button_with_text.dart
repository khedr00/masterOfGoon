import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';

class ButtonWithText extends StatefulWidget {
  const ButtonWithText({
    super.key,
    this.buttonAction,
    required this.widthOfButton,
    required this.heightOfButton,
    required this.text,
    this.textColor,
    this.fontSize,
  });
  final double widthOfButton;
  final double heightOfButton;
  final String text;
  final GestureTapCallback? buttonAction;
  final Color? textColor;
  final double? fontSize;

  @override
  State<ButtonWithText> createState() => _ButtonWithTextState();
}

class _ButtonWithTextState extends State<ButtonWithText> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Button(
      buttonAction: widget.buttonAction,
      widthOfButton: widget.widthOfButton,
      heightOfButton: widget.heightOfButton,
      borderRadiusOfButton: width * (10 / 1920),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor ?? Colors.black,
            fontFamily: 'NunitoSans-Medium',
            fontSize: widget.fontSize ?? width * (24 / 1920),
          ),
        ),
      ),
    );
  }
}
