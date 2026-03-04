import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class InternalChatButton extends StatelessWidget {
  const InternalChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (121 / 1920),
      height: width * (70 / 1920),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Center(
        child: SizedBox(
          width: width * (60 / 1920),
          height: width * (60 / 1920),
          child: Image.asset('assets/images/Chat.png'),
        ),
      ),
    );
  }
}
