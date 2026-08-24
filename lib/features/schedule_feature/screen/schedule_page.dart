import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/create_schedule.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/personal_and_deals_schedule_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isClicked = false;
  DateTime _dateTime = DateTime.now();
  String _dayName = '';
  String type = '';
  String date = '';
  String title = '';
  String description = '';
  String? saleLeaseDealId;
  String? buyRentDealId;

  bool _isCompletedSchedule = false;
  final CancelToken _cancelToken = CancelToken();

  Future<void> doCreateSchedule(
    String type,
    String date,
    String title,
    String description,
    String? saleLeaseDealId,
    String? buyRentDealId,
  ) async {
    String isCompletedOrRejectedSchedule = await createSchedule(
      cancelToken: _cancelToken,
      dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
      type: type,
      date: date,
      title: title,
      description: description,
      saleLeaseDealId: saleLeaseDealId,
      buyRentDealId: buyRentDealId,
    );
    setState(() {
      isCompletedOrRejectedSchedule == 'success'
          ? _isCompletedSchedule = true
          : _isCompletedSchedule = false;
    });
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );

    if (mounted && date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      setState(() {
        if (time != null) {
          _dateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          ).add(const Duration(hours: 3));
          _dayName = getDayNameFromDateTime(_dateTime);
          _isClicked = true;
        }
      });
    }
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
    double debugWidth = width * (900 / 1920);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: width * (20 / 1920)),
        child: Row(
          children: [
            SizedBox(
              width: debugWidth,
              child: Column(
                children: _isClicked
                    ? [
                        Text(
                          'Note date at : $_dayName ${_dateTime.toString().substring(0, 16)}',
                          style: TextStyle(
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width * (20 / 1920)),
                          child: CustomTextField(
                            fillColor: themeProvider.isDarkMode
                                ? darkThirdColorSecondary
                                : thirdColorSecondary,
                            onChanged: (value) {
                              title = value.trim();
                            },
                            hintText: 'Enter Title',
                            widthOfTextField: debugWidth / 1.2,
                            fontSize: 20,
                            fontFamily: FontFamily.light,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * (10 / 1920),
                            bottom: width * (30 / 1920),
                          ),
                          child: CustomTextField(
                            fillColor: themeProvider.isDarkMode
                                ? darkThirdColorSecondary
                                : thirdColorSecondary,
                            onChanged: (value) {
                              description = value.trim();
                            },
                            hintText: 'Enter Description',
                            fontSize: 20,
                            fontFamily: FontFamily.light,
                            widthOfTextField: debugWidth / 1.2,
                          ),
                        ),
                        Text(
                          'Attatch to a deal :',
                          style: TextStyle(
                            color: getPrimaryTextColor(
                              themeProvider.isDarkMode,
                            ),
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * (10 / 1920),
                            bottom: width * (30 / 1920),
                          ),
                          child: CustomTextField(
                            fillColor: themeProvider.isDarkMode
                                ? darkThirdColorSecondary
                                : thirdColorSecondary,
                            onChanged: (value) {
                              widget.userAuthInfo.role == 'PURCHASING' ||
                                      widget.userAuthInfo.role == 'RENTAL'
                                  ? buyRentDealId = value.trim()
                                  : saleLeaseDealId = value.trim();
                            },
                            hintText: 'ID',
                            widthOfTextField: debugWidth / 3,
                            fontSize: 20,
                            fontFamily: FontFamily.light,
                            maxLines: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonWithText(
                              widthOfButton: width * (139 / 1920),
                              heightOfButton: width * (84 / 1920),
                              text: 'cancel',
                              buttonAction: () {
                                setState(() {
                                  _isClicked = false;
                                });
                              },
                            ),
                            ButtonWithText(
                              widthOfButton: width * (139 / 1920),
                              heightOfButton: width * (84 / 1920),
                              text: 'confirm',
                              buttonAction: () async {
                                await doCreateSchedule(
                                  buyRentDealId != null && buyRentDealId != ''
                                      ? 'BUY_RENT_DEAL'
                                      : saleLeaseDealId != null &&
                                            saleLeaseDealId != ''
                                      ? 'SALE_LEASE_DEAL'
                                      : 'PERSONAL',
                                  _dateTime.toUtc().toIso8601String(),
                                  title,
                                  description,
                                  saleLeaseDealId,
                                  buyRentDealId,
                                );
                                if (_isCompletedSchedule) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Schedule is done',
                                          style: TextStyle(
                                            color: getPrimaryTextColor(
                                              themeProvider.isDarkMode,
                                            ),
                                            fontFamily: 'NunitoSans-Bold',
                                            fontSize: width * (24 / 1920),
                                          ),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Schedule is rejected',
                                          style: TextStyle(
                                            color: getPrimaryTextColor(
                                              themeProvider.isDarkMode,
                                            ),
                                            fontFamily: 'NunitoSans-Bold',
                                            fontSize: width * (24 / 1920),
                                          ),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    _isClicked = false;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ]
                    : [
                        ButtonWithText(
                          widthOfButton: width * (300 / 1920),
                          heightOfButton: width * (84 / 1920),
                          text: 'Add new scheduled note',
                          buttonAction: _pickDate,
                        ),
                      ],
              ),
            ),
            PersonalAndDealsScheduleWidget(
              key: ValueKey(description),
              fullHeight: width * (820 / 1920),

              userAuthInfo: widget.userAuthInfo,
            ),
          ],
        ),
      ),
    );
  }
}
