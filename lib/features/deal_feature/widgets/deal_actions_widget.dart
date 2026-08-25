import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/create_schedule.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/features/deal_feature/datasources/get_last_meeting.dart';
import 'package:untitled1/features/deal_feature/datasources/update_deal_status.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealActionsWidget extends StatefulWidget {
  const DealActionsWidget({
    super.key,
    required this.dealId,
    required this.isForBUYRENT,
    required this.userAuthInfo,
    required this.onDealUpdated,
  });
  final String dealId;
  final bool isForBUYRENT;
  final UserAuthInfo userAuthInfo;
  final Future<void> Function() onDealUpdated;

  @override
  State<DealActionsWidget> createState() => _DealActionsWidgetState();
}

class _DealActionsWidgetState extends State<DealActionsWidget> {
  final int _debugWidth = 881;
  final int _debugHeight = 827;

  DateTime _dateTime = DateTime.now();
  String _dayName = '';

  int isClicked = 0;

  Future<void> _showFailureDialog() async {
    final confirmed = await _showConfirmationDialog(
      title: 'Fail the deal?',
      message: 'Are you sure you want to mark this deal as failed?',
      confirmText: 'Confirm',
    );
    if (confirmed != true || !mounted) return;

    await _runDealUpdate(
      () => failDeal(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        dealId: widget.dealId,
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    final actualPriceController = TextEditingController();
    final actualListingPriceController = TextEditingController();
    final actualProfitMarginController = TextEditingController();
    final confirmed = await showDialog<Map<String, num>>(
      context: context,
      builder: (dialogContext) => _CompleteDealDialog(
        isForBuyRent: widget.isForBUYRENT,
        actualPriceController: actualPriceController,
        actualListingPriceController: actualListingPriceController,
        actualProfitMarginController: actualProfitMarginController,
      ),
    );
    actualPriceController.dispose();
    actualListingPriceController.dispose();
    actualProfitMarginController.dispose();
    if (confirmed == null || !mounted) return;

    await _runDealUpdate(
      () => completeDeal(
        dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
        dealId: widget.dealId,
        data: confirmed,
      ),
    );
  }

  Future<bool?> _showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => _ConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
      ),
    );
  }

  Future<void> _runDealUpdate(Future<String> Function() update) async {
    try {
      final message = await update();
      if (!mounted) return;
      setState(() => isClicked = 0);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      await widget.onDealUpdated();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
  }

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

  Future<void> g() async {
    await getLastMeeting(
      dealId: widget.dealId,
      userAuthInfo: widget.userAuthInfo,
    );
  }

  @override
  void initState() {
    g();
    super.initState();
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
                            buttonAction: _showFailureDialog,
                          ),
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'success',
                            buttonAction: _showSuccessDialog,
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

class _ConfirmationDialog extends StatelessWidget {
  const _ConfirmationDialog({
    required this.title,
    required this.message,
    required this.confirmText,
  });

  final String title;
  final String message;
  final String confirmText;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width * (500 / 1920),
        padding: EdgeInsets.all(width * (25 / 1920)),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(width * (15 / 1920)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (24 / 1920),
              ),
            ),
            SizedBox(height: width * (18 / 1920)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Medium',
                fontSize: width * (18 / 1920),
              ),
            ),
            SizedBox(height: width * (28 / 1920)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: 'Cancel',
                  buttonAction: () => Navigator.pop(context, false),
                ),
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: confirmText,
                  buttonAction: () => Navigator.pop(context, true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CompleteDealDialog extends StatelessWidget {
  const _CompleteDealDialog({
    required this.isForBuyRent,
    required this.actualPriceController,
    required this.actualListingPriceController,
    required this.actualProfitMarginController,
  });

  final bool isForBuyRent;
  final TextEditingController actualPriceController;
  final TextEditingController actualListingPriceController;
  final TextEditingController actualProfitMarginController;

  num? _number(String value) => num.tryParse(value.trim());

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final fields = <Widget>[
      _numberField(context, 'Actual price', actualPriceController),
      if (!isForBuyRent) ...[
        SizedBox(height: width * (12 / 1920)),
        _numberField(
          context,
          'Actual listing price',
          actualListingPriceController,
        ),
        SizedBox(height: width * (12 / 1920)),
        _numberField(
          context,
          'Actual profit margin',
          actualProfitMarginController,
        ),
      ],
    ];
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: width * (560 / 1920),
        padding: EdgeInsets.all(width * (25 / 1920)),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(width * (15 / 1920)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Complete the deal?',
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Bold',
                fontSize: width * (24 / 1920),
              ),
            ),
            SizedBox(height: width * (20 / 1920)),
            ...fields,
            SizedBox(height: width * (28 / 1920)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: 'Cancel',
                  buttonAction: () => Navigator.pop(context),
                ),
                ButtonWithText(
                  widthOfButton: width * (130 / 1920),
                  heightOfButton: width * (45 / 1920),
                  text: 'Confirm',
                  buttonAction: () {
                    final actualPrice = _number(actualPriceController.text);
                    final actualListingPrice = _number(
                      actualListingPriceController.text,
                    );
                    final actualProfitMargin = _number(
                      actualProfitMarginController.text,
                    );
                    if (actualPrice == null ||
                        (!isForBuyRent &&
                            (actualListingPrice == null ||
                                actualProfitMargin == null))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter valid numeric values'),
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, {
                      'actualPrice': actualPrice,
                      if (!isForBuyRent)
                        'actualListingPrice': actualListingPrice!,
                      if (!isForBuyRent)
                        'actualProfitMargin': actualProfitMargin!,
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberField(
    BuildContext context,
    String hintText,
    TextEditingController controller,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CustomTextField(
      onChanged: (_) {},
      hintText: hintText,
      widthOfTextField: 510,
      fillColor: getInputBackgroundColor(themeProvider.isDarkMode),
      fontSize: 18,
      fontFamily: FontFamily.light,
      controller: controller,
      maxLines: 1,
    );
  }
}
