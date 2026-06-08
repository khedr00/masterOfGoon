import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/double_button/double_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/new_and_ongoing_deals_db_provider.dart';

class NewAndOngoingDealsButton extends StatefulWidget {
  const NewAndOngoingDealsButton({super.key});

  @override
  State<NewAndOngoingDealsButton> createState() =>
      _NewAndOngoingDealsButtonState();
}

class _NewAndOngoingDealsButtonState extends State<NewAndOngoingDealsButton> {
  bool _secondClick = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final newAndOngoingDealsDbProvider =
        Provider.of<NewAndOngoingDealsDbProvider>(context);
    return DoubleButton(
      firstButtonName: 'Ongoing',
      secondButtonName: 'New',
      fillColor: primaryColor,
      widthOfButton: width * (150 / 1920),
      firstButtonAction: () {
        setState(() {
          _secondClick = false;
          newAndOngoingDealsDbProvider.falsingNewAreClicked();
        });
      },
      secondButtonAction: () {
        setState(() {
          _secondClick = true;
          newAndOngoingDealsDbProvider.truingNewAreClicked();
        });
      },
      secondClick: _secondClick,
    );
  }
}
