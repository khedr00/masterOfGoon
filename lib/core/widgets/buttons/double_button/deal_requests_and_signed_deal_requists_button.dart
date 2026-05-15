import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/double_button/double_button.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealRequestsAndSignedDealRequistsButton extends StatefulWidget {
  const DealRequestsAndSignedDealRequistsButton({super.key});

  @override
  State<DealRequestsAndSignedDealRequistsButton> createState() =>
      _DealRequestsAndSignedDealRequistsButtonState();
}

class _DealRequestsAndSignedDealRequistsButtonState
    extends State<DealRequestsAndSignedDealRequistsButton> {
  bool _secondClick = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DoubleButton(
      firstButtonName: 'Deal requests',
      secondButtonName: 'Signed deal requests',
      fillColor: primaryColor,
      widthOfButton: width * (350 / 1920),
      firstButtonAction: () {
        setState(() {
          _secondClick = false;
        });
      },
      secondButtonAction: () {
        setState(() {
          _secondClick = true;
        });
      },
      secondClick: _secondClick,
    );
  }
}
