import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';

class ContactSupportButton extends StatefulWidget {
  const ContactSupportButton({super.key});

  @override
  State<ContactSupportButton> createState() => _ContactSupportButtonState();
}

class _ContactSupportButtonState extends State<ContactSupportButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (220 / 1920),
      height: width * (50 / 1920),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Row(
        children: [
          SizedBox(width: width * (10 / 1920)),
          ButtonWithImage(
            image: 'assets/images/Online Support.png',
            widthOfButton: width * (40 / 1920),
            heightOfButton: width * (40 / 1920),
            widthOfImage: width * (40 / 1920),
            heightOfImage: width * (40 / 1920),
          ),
          SizedBox(width: width * (10 / 1920)),
          ButtonWithText(
            widthOfButton: width * (150 / 1920),
            heightOfButton: width * (30 / 1920),
            text: 'contact support',
            textColor: Colors.white,
            fontSize: width * (18 / 1920),
          ),
        ],
      ),
    );
  }
}
