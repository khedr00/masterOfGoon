import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_and_avoidances_cards/liked_only_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_and_avoidances_general_body.dart';

class LikedOnlyBody extends StatelessWidget {
  const LikedOnlyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LikedAndAvoidancesGeneralBody(
      notesList: [
        LikedOnlyCard(),
        LikedOnlyCard(),
        LikedOnlyCard(),
        LikedOnlyCard(),
        LikedOnlyCard(),
        LikedOnlyCard(),
        LikedOnlyCard(),
      ],
    );
  }
}
