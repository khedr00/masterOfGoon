import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/create_schedule.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealActionsWidget extends StatefulWidget {
  const DealActionsWidget({
    super.key,
    required this.dealId,
    required this.isForBUYRENT,
    required this.userAuthInfo,
  });
  final String dealId;
  final bool isForBUYRENT;
  final UserAuthInfo userAuthInfo;

  @override
  State<DealActionsWidget> createState() => _DealActionsWidgetState();
}

class _DealActionsWidgetState extends State<DealActionsWidget> {
  final int _debugWidth = 881;
  final int _debugHeight = 827;

  DateTime _dateTime = DateTime.now();
  String _dayName = '';

  int isClicked = 0;

  void _onTextChanged(String value) {}

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
          );
          isClicked = 1;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    _dayName = getDayNameFromDateTime(_dateTime);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (_debugWidth / 1920),
      height: width * (_debugHeight / 1920),
      decoration: BoxDecoration(
        color: getCardColor(themeProvider.isDarkMode),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(width * (30 / 1920)),
          bottomLeft: Radius.circular(width * (30 / 1920)),
          bottomRight: Radius.circular(width * (30 / 1920)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.isForBUYRENT
              ? isClicked == 1
                    ? Container(
                        width: width * (_debugWidth / 1920),
                        height: width * (((_debugHeight / 4) * 2) / 1920),
                        color: getCardColor(themeProvider.isDarkMode),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: width * (10 / 1920),
                              ),
                              child: Text(
                                'MEETING date at : $_dayName ${_dateTime.toString().substring(0, 16)}',
                                style: TextStyle(
                                  color: getPrimaryTextColor(
                                    themeProvider.isDarkMode,
                                  ),
                                  fontFamily: 'NunitoSans-Bold',
                                  fontSize: width * (24 / 1920),
                                ),
                              ),
                            ),
                            CustomTextField(
                              fillColor: themeProvider.isDarkMode
                                  ? darkThirdColorSecondary
                                  : thirdColorSecondary,
                              onChanged: _onTextChanged,
                              hintText: 'Enter Description',
                              fontSize: 20,
                              fontFamily: FontFamily.light,
                              widthOfTextField: _debugWidth / 1.2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonWithText(
                                  widthOfButton: width * (139 / 1920),
                                  heightOfButton: width * (84 / 1920),
                                  text: 'cancel',
                                  buttonAction: () async {
                                    await createSchedule(
                                      dioClient: DioClient(
                                        userAuthInfo: widget.userAuthInfo,
                                      ),
                                      type: widget.isForBUYRENT
                                          ? 'BUY_RENT_DEAL'
                                          : 'SALE_LEASE_DEAL',
                                      date: _dateTime.toUtc().toIso8601String(),
                                      title: 'MEETING',
                                      description: "you have a meeting ",
                                      buyRentDealId: widget.dealId,
                                    );
                                    setState(() {
                                      isClicked = 0;
                                    });
                                  },
                                ),
                                ButtonWithText(
                                  widthOfButton: width * (139 / 1920),
                                  heightOfButton: width * (84 / 1920),
                                  text: 'confirm',
                                  buttonAction: () async {
                                    setState(() {
                                      isClicked = 0;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: width * (30 / 1920)),
                          ],
                        ),
                      )
                    : Container(
                        width: width * (_debugWidth / 1920),
                        color: getCardColor(themeProvider.isDarkMode),
                        child: Center(
                          child: ButtonWithText(
                            widthOfButton: width * (261 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'set up the MEETING',
                            buttonAction: () {
                              _pickDate();
                            },
                          ),
                        ),
                      )
              : SizedBox(),
          // isClicked == 2
          //     ? Container(
          //         width: width * (_debugWidth / 1920),
          //         height: width * (((_debugHeight / 4) * 2) / 1920),
          //         color: getCardColor(themeProvider.isDarkMode),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             Padding(
          //               padding: EdgeInsets.symmetric(
          //                 vertical: width * (10 / 1920),
          //               ),
          //               child: Text(
          //                 'please address the reason for reassign request : ',
          //                 style: TextStyle(
          //                   color: getPrimaryTextColor(
          //                     themeProvider.isDarkMode,
          //                   ),
          //                   fontFamily: 'NunitoSans-Bold',
          //                   fontSize: width * (24 / 1920),
          //                 ),
          //               ),
          //             ),
          //             CustomTextField(
          //               fillColor: themeProvider.isDarkMode
          //                   ? darkThirdColorSecondary
          //                   : thirdColorSecondary,
          //               onChanged: _onTextChanged,
          //               hintText: 'Enter Description',
          //               fontSize: 20,
          //               fontFamily: FontFamily.light,
          //               widthOfTextField: _debugWidth / 1.2,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 ButtonWithText(
          //                   widthOfButton: width * (139 / 1920),
          //                   heightOfButton: width * (84 / 1920),
          //                   text: 'cancel',
          //                   buttonAction: () {
          //                     setState(() {
          //                       isClicked = 0;
          //                     });
          //                   },
          //                 ),
          //                 ButtonWithText(
          //                   widthOfButton: width * (139 / 1920),
          //                   heightOfButton: width * (84 / 1920),
          //                   text: 'confirm',
          //                   buttonAction: () {
          //                     setState(() {
          //                       isClicked = 0;
          //                     });
          //                   },
          //                 ),
          //               ],
          //             ),
          //             SizedBox(height: width * (30 / 1920)),
          //           ],
          //         ),
          //       )
          // : Container(
          //     width: width * (_debugWidth / 1920),
          //     color: getCardColor(themeProvider.isDarkMode),
          //     child: Center(
          //       child: ButtonWithText(
          //         widthOfButton: width * (261 / 1920),
          //         heightOfButton: width * (84 / 1920),
          //         text: 'reassign the deal',
          //         buttonAction: () {
          //           setState(() {
          //             isClicked = 2;
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          widget.isForBUYRENT
              ? Container(
                  width: width * (_debugWidth / 1920),
                  color: getCardColor(themeProvider.isDarkMode),
                  child: Center(
                    child: ButtonWithText(
                      widthOfButton: width * (261 / 1920),
                      heightOfButton: width * (84 / 1920),
                      text: 'change the property',
                    ),
                  ),
                )
              : SizedBox(),
          isClicked == 4
              ? Container(
                  width: width * (_debugWidth / 1920),
                  height: width * (((_debugHeight / 4) * 2) / 1920),
                  color: getCardColor(themeProvider.isDarkMode),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'failure',
                            buttonAction: () {
                              setState(() {
                                isClicked = 0;
                              });
                            },
                          ),
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'success',
                            buttonAction: () {
                              setState(() {
                                isClicked = 0;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: width * (30 / 1920)),
                    ],
                  ),
                )
              : Container(
                  width: width * (_debugWidth / 1920),
                  color: getCardColor(themeProvider.isDarkMode),
                  child: Center(
                    child: ButtonWithText(
                      widthOfButton: width * (261 / 1920),
                      heightOfButton: width * (84 / 1920),
                      text: 'close the deal',
                      buttonAction: () {
                        setState(() {
                          isClicked = 4;
                        });
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
