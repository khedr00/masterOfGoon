import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.maxLines,
    required this.widthOfTextField,
  });
  final void Function(String) onChanged;
  final String hintText;
  final double widthOfTextField;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (widthOfTextField / 1920),
      child: TextField(
        controller: TextEditingController(),
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color.fromARGB(151, 255, 255, 255),
            fontFamily: 'NunitoSans-Light',
          ),
          filled: true,
          fillColor: thirdColorSecondary,
        ),
        maxLines: maxLines ?? 3,
      ),
    );
  }
}
