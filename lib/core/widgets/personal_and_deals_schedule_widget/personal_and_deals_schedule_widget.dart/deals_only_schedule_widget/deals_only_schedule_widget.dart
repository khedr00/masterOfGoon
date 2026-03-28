import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/Deals_only_schedule_widget/deals_notes_widget.dart';

class DealsOnlyScheduleWidget extends StatefulWidget {
  const DealsOnlyScheduleWidget({
    super.key,
    required this.dealNotes,
    required this.apoitmentsNotes,
    required this.forDealPage,
  });
  final List<String> dealNotes;
  final List<DealsNotesWidget> apoitmentsNotes;
  final bool forDealPage;

  @override
  State<DealsOnlyScheduleWidget> createState() =>
      _DealsOnlyScheduleWidgetState();
}

class _DealsOnlyScheduleWidgetState extends State<DealsOnlyScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> dealsNotes = [];
    List<Widget> apoitmentsNotesWithPaddings = [];
    for (int i = 0; i < widget.dealNotes.length; i++) {
      dealsNotes.add(
        Padding(
          padding: EdgeInsets.all(width * (10 / 1920)),
          child: Text(
            '${(i + 1).toString()}_${widget.dealNotes[i]}',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NunitoSans-Bold',
              fontSize: width * (24 / 1920),
            ),
          ),
        ),
      );
    }
    for (int i = 0; i < widget.apoitmentsNotes.length; i++) {
      apoitmentsNotesWithPaddings.add(
        Padding(
          padding: EdgeInsetsGeometry.only(top: width * (60 / 1920)),
          child: widget.apoitmentsNotes[i],
        ),
      );
    }

    return Container(
      width: width * (881 / 1920),
      height: width * (827 / 1920),
      decoration: widget.forDealPage
          ? BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (30 / 1920)),
                bottomLeft: Radius.circular(width * (30 / 1920)),
                bottomRight: Radius.circular(width * (30 / 1920)),
              ),
            )
          : BoxDecoration(
              color: backGroundColor,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
              border: Border.all(
                color: thirdColorPrimary,
                width: width * (4 / 1920),
              ),
            ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width * (881 / 1920),
              // height: width * (177 / 1920),
              decoration: BoxDecoration(color: thirdColorPrimary),
              child: Column(children: dealsNotes),
            ),
            Column(children: apoitmentsNotesWithPaddings),
          ],
        ),
      ),
    );
  }
}
