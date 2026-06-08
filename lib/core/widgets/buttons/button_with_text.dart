import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            color: widget.textColor ?? getPrimaryTextColor(themeProvider.isDarkMode),
            fontFamily: 'NunitoSans-Medium',
            fontSize: widget.fontSize ?? width * (24 / 1920),
          ),
        ),
      ),
    );
  }
}
