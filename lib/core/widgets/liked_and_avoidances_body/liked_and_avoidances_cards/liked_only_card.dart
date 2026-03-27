import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_and_avoidances_cards/liked_and_avoidances_general_card.dart';

class LikedOnlyCard extends StatelessWidget {
  const LikedOnlyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LikedAndAvoidancesGeneralCard(
      color: fifthColorSecondaryLightGreen,
      theNote: 'don’t forget to show him the house and the pool',
    );
  }
}
