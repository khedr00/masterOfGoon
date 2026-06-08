import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

enum FontFamily { bold, light }

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.maxLines,
    required this.widthOfTextField,
    required this.fillColor,
    required this.fontSize,
    required this.fontFamily,
  });
  final Color fillColor;
  final void Function(String) onChanged;
  final String hintText;
  final double widthOfTextField;
  final int? maxLines;
  final int fontSize;
  final FontFamily fontFamily;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    final String fontFamilyUsed = fontFamily == FontFamily.bold
        ? 'NunitoSans-Bold'
        : 'NunitoSans-Light';
    return SizedBox(
      width: width * (widthOfTextField / 1920),
      child: TextField(
        controller: TextEditingController(),
        onChanged: onChanged,
        cursorColor: getPrimaryTextColor(themeProvider.isDarkMode),
        style: TextStyle(
          fontSize: width * (fontSize / 1920),
          fontFamily: fontFamilyUsed,
          color: getPrimaryTextColor(themeProvider.isDarkMode),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: width * ((fontSize * (45 / 32)) / 1920),
            horizontal: width * ((fontSize * (40 / 32)) / 1920),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * (15 / 1920)),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          //  InputBorder.none  ,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: width * (fontSize / 1920),
            color: fillColor == getCardColor(themeProvider.isDarkMode)
                ? getHintTextColor(themeProvider.isDarkMode)
                : getHintTextColor(themeProvider.isDarkMode),
            fontFamily: fontFamilyUsed,
          ),
          filled: true,
          fillColor: fillColor,
        ),
        maxLines: maxLines ?? 3,
      ),
    );
  }
}
