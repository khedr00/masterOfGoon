import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/inside_tab_personal_and_deal_schedule_widget.dart';

class DealsNotesWidget extends StatefulWidget {
  const DealsNotesWidget({
    super.key,
    required this.dealApoitmentNotes,
    required this.dateTime,
  });

  final List<DealNoteWidget> dealApoitmentNotes;
  final DateTime dateTime;

  @override
  State<DealsNotesWidget> createState() => _PersonalScheduleWidgetState();
}

class _PersonalScheduleWidgetState extends State<DealsNotesWidget> {
  String _dayName = '';
  String _date = '';
  void getDayName() {
    _dayName = getDayNameFromDateTime(widget.dateTime);
  }

  void getDate() {
    _date = getDateFromDateTime(widget.dateTime);
  }

  @override
  void initState() {
    getDayName();
    getDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (821 / 1920),
      height: width * (403 / 1920),
      child: GeneralTabableCard(
        tabs: [
          TabOfTabableCard(
            tabName: '$_dayName $_date',
            tabColor: thirdColorPrimary,
            bodyOfTheTab: InsideTabPersonalAndDealScheduleWidget(
              personalAndDealsNotes: widget.dealApoitmentNotes,
            ),
          ),
        ],
        fullCardWidth: width * (821 / 1920),
        fullCardHeight: width * (301 / 1920),
      ),
    );
  }
}
