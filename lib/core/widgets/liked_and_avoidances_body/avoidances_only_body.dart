import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_and_avoidances_cards/avoidance_only_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_and_avoidances_general_body.dart';

class AvoidancesOnlyBody extends StatelessWidget {
  const AvoidancesOnlyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LikedAndAvoidancesGeneralBody(
      notesList: [
        AvoidanceOnlyCard(),
        AvoidanceOnlyCard(),
        AvoidanceOnlyCard(),
        AvoidanceOnlyCard(),
        AvoidanceOnlyCard(),
        AvoidanceOnlyCard(),
      ],
    );
  }
}
