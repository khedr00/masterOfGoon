import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';

class InternalChatButton extends StatelessWidget {
  const InternalChatButton({super.key, this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ButtonWithImage(
      widthOfButton: width * (121 / 1920),
      heightOfButton: width * (70 / 1920),
      heightOfImage: width * (60 / 1920),
      widthOfImage: width * (60 / 1920),
      image: 'assets/images/Chat.png',
      buttonAction: onTap ?? () {},
    );
  }
}
