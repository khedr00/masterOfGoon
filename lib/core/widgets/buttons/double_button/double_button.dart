import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DoubleButton extends StatefulWidget {
  const DoubleButton({
    super.key,
    required this.firstButtonName,
    required this.secondButtonName,
    required this.fillColor,
    required this.widthOfButton,
    this.firstButtonAction,
    this.secondButtonAction,
    required this.secondClick,
  });
  final String firstButtonName;
  final String secondButtonName;
  final Color fillColor;
  final double widthOfButton;
  final GestureTapCallback? firstButtonAction;
  final GestureTapCallback? secondButtonAction;
  final bool secondClick;

  @override
  State<DoubleButton> createState() => _DoubleButton();
}

class _DoubleButton extends State<DoubleButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: widget.widthOfButton,
      height: width * (40 / 1902),
      decoration: BoxDecoration(
        border: Border.all(color: widget.fillColor, width: width * (4 / 1920)),
        color: getCardColor(themeProvider.isDarkMode),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.firstButtonAction != null
                    ? widget.firstButtonAction!()
                    : DoNothingAction;
              });
            },
            child: Container(
              width: (widget.widthOfButton / 2) - width * (4 / 1920),
              height: width * (36 / 1920),
              decoration: BoxDecoration(
                color: !widget.secondClick ? getCardColor(themeProvider.isDarkMode) : widget.fillColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1000),
                  bottomLeft: Radius.circular(1000),
                ),
              ),
              child: Center(
                child: Text(
                  widget.firstButtonName,
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (14 / 1920),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.secondButtonAction != null
                    ? widget.secondButtonAction!()
                    : DoNothingAction;
              });
            },
            child: Container(
              width: (widget.widthOfButton / 2) - width * (4 / 1920),
              height: width * (36 / 1920),
              decoration: BoxDecoration(
                color: widget.secondClick ? getCardColor(themeProvider.isDarkMode) : widget.fillColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(1000),
                  bottomRight: Radius.circular(1000),
                ),
              ),
              child: Center(
                child: Text(
                  widget.secondButtonName,
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (14 / 1920),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
