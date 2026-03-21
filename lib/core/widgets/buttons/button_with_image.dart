import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button.dart';

class ButtonWithImage extends StatefulWidget {
  const ButtonWithImage({
    super.key,
    required this.image,
    this.buttonAction,
    required this.widthOfButton,
    required this.heightOfButton,
    required this.widthOfImage,
    required this.heightOfImage,
  });
  final double widthOfButton;
  final double heightOfButton;
  final double widthOfImage;
  final double heightOfImage;
  final String image;
  final GestureTapCallback? buttonAction;

  @override
  State<ButtonWithImage> createState() => _ButtonWithImageState();
}

class _ButtonWithImageState extends State<ButtonWithImage> {
  @override
  Widget build(BuildContext context) {
    return Button(
      buttonAction: widget.buttonAction,
      widthOfButton: widget.widthOfButton,
      heightOfButton: widget.heightOfButton,
      borderRadiusOfButton: 1000,
      child: SizedBox(
        width: widget.widthOfImage,
        height: widget.heightOfButton,
        child: Image.asset(widget.image),
      ),
    );
  }
}
