import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/inside_tab_personal_and_deal_schedule_widget.dart';

class PersonalAndDealsScheduleWidget extends StatefulWidget {
  const PersonalAndDealsScheduleWidget({
    super.key,
    required this.personalAndDealsNotes,
  });

  final List<dynamic> personalAndDealsNotes;

  @override
  State<PersonalAndDealsScheduleWidget> createState() =>
      _PersonalScheduleWidgetState();
}

class _PersonalScheduleWidgetState
    extends State<PersonalAndDealsScheduleWidget> {
  DateTime _dateTime = DateTime.now();
  String _dayName = '';
  String _date = '';
  void getDayName() {
    _dayName = getDayNameFromDateTime(_dateTime);
  }

  void getDate() {
    _date = getDateFromDateTime(_dateTime);
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    setState(() {
      if (date != null) {
        _dateTime = date;
      }
    });
    getDayName();
    getDate();
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
    return Stack(
      children: [
        SizedBox(
          width: width * (881 / 1920),
          height: width * (827 / 1920),
          child: GeneralTabableCard(
            tabs: [
              TabOfTabableCard(
                tabName: '$_dayName $_date',
                tabColor: thirdColorPrimary,
                bodyOfTheTab: InsideTabPersonalAndDealScheduleWidget(
                  personalAndDealsNotes: widget.personalAndDealsNotes,
                ),
              ),
            ],
            fullCardWidth: width * (881 / 1920),
            fullCardHeight: width * (760 / 1920),
          ),
        ),
        Positioned(
          right: width * (140 / 1920),
          child: GestureDetector(
            onTap: _pickDate,
            //  () async {
            //   await _pickDate();
            //   getDayName();
            //   getDate();
            // },
            child: Container(
              width: width * (45 / 1920),
              height: width * (45 / 1920),
              decoration: BoxDecoration(
                color: thirdColorPrimary,
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
              child: Image.asset('assets/images/Calendar.png'),
            ),
          ),
        ),
      ],
    );
  }
}
