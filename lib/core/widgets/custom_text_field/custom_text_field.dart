import 'package:flutter/material.dart';

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
    double width = MediaQuery.of(context).size.width;
    final String fontFamilyUsed = fontFamily == FontFamily.bold
        ? 'NunitoSans-Bold'
        : 'NunitoSans-Light';
    return SizedBox(
      width: width * (widthOfTextField / 1920),
      child: TextField(
        controller: TextEditingController(),
        onChanged: onChanged,
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: width * (fontSize / 1920),
          fontFamily: fontFamilyUsed,
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
            color: fillColor == Colors.white
                ? const Color.fromARGB(87, 0, 0, 0)
                : const Color.fromARGB(151, 255, 255, 255),
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
