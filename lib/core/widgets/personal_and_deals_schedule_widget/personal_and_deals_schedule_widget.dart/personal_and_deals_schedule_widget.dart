import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/get_personal_and_deals_schedule_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/inside_tab_personal_and_deal_schedule_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class PersonalAndDealsScheduleWidget extends StatefulWidget {
  const PersonalAndDealsScheduleWidget({
    super.key,
    this.fullHeight,
    required this.employeeId,
  });

  final double? fullHeight;
  final int employeeId;

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
        _getPersonalAndDealsScheduleInfo();
      }
    });
    getDayName();
    getDate();
  }

  List<dynamic> _scheduleNotes = [];
  final CancelToken _cancelToken = CancelToken();
  void _getPersonalAndDealsScheduleInfo() async {
    List<dynamic> scheduleNote = await getPersonalAndDealsScheduleInfo(
      employeeId: widget.employeeId,
      dateTime: _dateTime,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _scheduleNotes = [];
      _scheduleNotes.addAll(scheduleNote);
    });
  }

  @override
  void initState() {
    getDayName();
    getDate();
    _getPersonalAndDealsScheduleInfo();
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    if (_scheduleNotes.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }
    return Stack(
      children: [
        SizedBox(
          width: width * (881 / 1920),
          // height: width * (827 / 1920),
          child: GeneralTabableCard(
            tabs: [
              TabOfTabableCard(
                tabName: '$_dayName $_date',
                tabColor: themeProvider.isDarkMode
                    ? darkThirdColorPrimary
                    : thirdColorPrimary,
                bodyOfTheTab: InsideTabPersonalAndDealScheduleWidget(
                  personalAndDealsNotes: _scheduleNotes,
                  fullHeight: widget.fullHeight ?? width * (760 / 1920),
                ),
              ),
            ],
            fullCardWidth: width * (881 / 1920),
            fullCardHeight: widget.fullHeight ?? width * (760 / 1920),
          ),
        ),
        Positioned(
          right: width * (140 / 1920),
          child: GestureDetector(
            onTap: _pickDate,
            child: Container(
              width: width * (45 / 1920),
              height: width * (45 / 1920),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? darkThirdColorPrimary
                    : thirdColorPrimary,
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
