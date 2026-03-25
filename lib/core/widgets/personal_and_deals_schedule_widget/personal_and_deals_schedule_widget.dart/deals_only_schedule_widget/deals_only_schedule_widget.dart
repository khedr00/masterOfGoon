import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/Deals_only_schedule_widget/deals_notes_widget.dart';

class DealsOnlyScheduleWidget extends StatefulWidget {
  const DealsOnlyScheduleWidget({
    super.key,
    required this.dealNotes,
    required this.apoitmentsNotes,
  });
  final List<String> dealNotes;
  final List<DealsNotesWidget> apoitmentsNotes;

  @override
  State<DealsOnlyScheduleWidget> createState() =>
      _DealsOnlyScheduleWidgetState();
}

class _DealsOnlyScheduleWidgetState extends State<DealsOnlyScheduleWidget> {
  final List<Widget> _dealsNotes = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    for (int i = 0; i < widget.dealNotes.length; i++) {
      _dealsNotes.add(
        Text(
          widget.dealNotes[i],
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'NunitoSans-Bold',
            fontSize: width * (24 / 1920),
          ),
        ),
      );
    }
    return Container(
      width: width * (881 / 1920),
      height: width * (827 / 1920),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Column(
        children: [
          Container(
            height: width * (177 / 1920),
            decoration: BoxDecoration(
              color: thirdColorPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
                topRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Column(children: _dealsNotes),
          ),
          SizedBox(
            width: width * (881 / 1920),
            height: width * (650 / 1920),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int i) {
                return Column(
                  children: [
                    SizedBox(height: width * (50 / 1920)),
                    widget.apoitmentsNotes[i],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
