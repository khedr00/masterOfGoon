import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/contact_support_button/widgets/contact_support_dialog.dart';

class ContactSupportButton extends StatefulWidget {
  const ContactSupportButton({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<ContactSupportButton> createState() => _ContactSupportButtonState();
}

class _ContactSupportButtonState extends State<ContactSupportButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ContactSupportDialog(userAuthInfo: widget.userAuthInfo);
          },
        );
      },
      child: Container(
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
      ),
    );
  }
}
