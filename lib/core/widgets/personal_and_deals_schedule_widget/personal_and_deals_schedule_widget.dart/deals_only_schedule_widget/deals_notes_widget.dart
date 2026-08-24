import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/inside_tab_personal_and_deal_schedule_widget.dart';

class DealsNotesWidget extends StatelessWidget {
  const DealsNotesWidget({super.key, required this.dealApoitmentNotes});

  final List<dynamic> dealApoitmentNotes;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (821 / 1920),
      height: width * (403 / 1920),
      child: GeneralTabableCard(
        tabs: [
          TabOfTabableCard(
            tabName: dealApoitmentNotes[0].scheduleDealNote.time!,
            tabColor: thirdColorPrimary,
            bodyOfTheTab: InsideTabPersonalAndDealScheduleWidget(
              personalAndDealsNotes: dealApoitmentNotes,
            ),
          ),
        ],
        fullCardWidth: width * (821 / 1920),
        fullCardHeight: width * (301 / 1920),
      ),
    );
  }
}
