import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/double_button/double_button.dart';
import 'package:untitled1/core/widgets/constants.dart';

class NewAndOngoingDealsButton extends StatefulWidget {
  const NewAndOngoingDealsButton({super.key});

  @override
  State<NewAndOngoingDealsButton> createState() =>
      _NewAndOngoingDealsButtonState();
}

class _NewAndOngoingDealsButtonState extends State<NewAndOngoingDealsButton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DoubleButton(
      firstButtonName: 'Ongoing',
      secondButtonName: 'New',
      fillColor: primaryColor,
      widthOfButton: width * (150 / 1920),
    );
  }
}
