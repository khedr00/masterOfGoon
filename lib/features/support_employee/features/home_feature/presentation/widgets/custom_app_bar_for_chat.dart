import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/core/widgets/app_image.dart';
import 'package:untitled1/features/support_employee/core/widgets/custom_font.dart';

class CustomAppBarForChat extends StatefulWidget {
  const CustomAppBarForChat({super.key});

  @override
  State<CustomAppBarForChat> createState() => _CustomAppBarForChatState();
}

class _CustomAppBarForChatState extends State<CustomAppBarForChat> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.02),
      child: Container(
        height: width * 0.05,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.015),
            topRight: Radius.circular(width * 0.015),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: width * 0.01),
            AppImage(
              path: 'assets/images/profilePhoto-icon.png',
              width: width * 0.04,
              height: width * 0.04,
            ),
            SizedBox(width: width * 0.01),
            CustomFont(
              name: 'Ahmad Issa',
              fontColor: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: width * 0.015,
            ),
            SizedBox(width: width * 0.03),
            AppImage(
              path: 'assets/images/Address Book.png',
              width: width * 0.025,
              height: width * 0.025,
            ),
            SizedBox(width: width * 0.01),
            CustomFont(
              name: 'AKheder Issa',
              fontColor: Colors.white,

              fontSize: width * 0.012,
            ),
            SizedBox(width: width * 0.02),
            AppImage(
              path: 'assets/images/Phone.png',
              width: width * 0.025,
              height: width * 0.025,
            ),
            SizedBox(width: width * 0.01),
            CustomFont(
              name: '0937638454',
              fontColor: Colors.white,

              fontSize: width * 0.015,
            ),
            SizedBox(width: width * 0.01),
          ],
        ),
      ),
    );
  }
}
