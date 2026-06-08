import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key, this.buttonAction});

  final GestureTapCallback? buttonAction;

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ButtonWithImage(
      image: 'assets/images/Slider.png',
      widthOfButton: width * (60 / 1920),
      heightOfButton: width * (40 / 1920),
      heightOfImage: width * (30 / 1920),
      widthOfImage: width * (30 / 1920),
      buttonAction: widget.buttonAction,
    );
  }
}
