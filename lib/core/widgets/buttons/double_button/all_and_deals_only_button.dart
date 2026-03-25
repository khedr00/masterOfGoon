import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/double_button/double_button.dart';
import 'package:untitled1/core/widgets/constants.dart';

class AllAndDealsOnlyButton extends StatefulWidget {
  const AllAndDealsOnlyButton({super.key});

  @override
  State<AllAndDealsOnlyButton> createState() => _AllAndDealsOnlyButtonState();
}

class _AllAndDealsOnlyButtonState extends State<AllAndDealsOnlyButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DoubleButton(
      firstButtonName: 'All',
      secondButtonName: 'Deals only',
      fillColor: thirdColorPrimary,
      widthOfButton: width * (200 / 1920),
    );
  }
}
