import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealActionsWidget extends StatefulWidget {
  const DealActionsWidget({super.key});

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
    _dayName = getDayNameFromDateTime(_dateTime);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (_debugWidth / 1920),
      height: width * (_debugHeight / 1920),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(width * (30 / 1920)),
          bottomLeft: Radius.circular(width * (30 / 1920)),
          bottomRight: Radius.circular(width * (30 / 1920)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isClicked == 1
              ? Container(
                  width: width * (_debugWidth / 1920),
                  height: width * (((_debugHeight / 4) * 2) / 1920),
                  color: Colors.white,
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
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * ((_debugWidth / 1.2) / 1920),
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: _onTextChanged,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Description',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              fontFamily: 'NunitoSans-Light',
                            ),
                            filled: true,
                            fillColor: thirdColorSecondary,
                          ),
                          maxLines: 3,
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
                                isClicked = 0;
                              });
                            },
                          ),
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'confirm',
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
                  color: Colors.white,
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
                ),
          isClicked == 2
              ? Container(
                  width: width * (_debugWidth / 1920),
                  height: width * (((_debugHeight / 4) * 2) / 1920),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: width * (10 / 1920),
                        ),
                        child: Text(
                          'please address the reason for reassign request : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * ((_debugWidth / 1.2) / 1920),
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: _onTextChanged,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Description',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              fontFamily: 'NunitoSans-Light',
                            ),
                            filled: true,
                            fillColor: thirdColorSecondary,
                          ),
                          maxLines: 3,
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
                                isClicked = 0;
                              });
                            },
                          ),
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'confirm',
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
                  color: Colors.white,
                  child: Center(
                    child: ButtonWithText(
                      widthOfButton: width * (261 / 1920),
                      heightOfButton: width * (84 / 1920),
                      text: 'reassign the deal',
                      buttonAction: () {
                        setState(() {
                          isClicked = 2;
                        });
                      },
                    ),
                  ),
                ),
          Container(
            width: width * (_debugWidth / 1920),
            color: Colors.white,
            child: Center(
              child: ButtonWithText(
                widthOfButton: width * (261 / 1920),
                heightOfButton: width * (84 / 1920),
                text: 'change the property',
              ),
            ),
          ),
          isClicked == 4
              ? Container(
                  width: width * (_debugWidth / 1920),
                  height: width * (((_debugHeight / 4) * 2) / 1920),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: width * (10 / 1920),
                        ),
                        child: Text(
                          'please address the reason for cancelling the deal : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * ((_debugWidth / 1.2) / 1920),
                        child: TextField(
                          controller: TextEditingController(),
                          onChanged: _onTextChanged,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Description',
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(151, 255, 255, 255),
                              fontFamily: 'NunitoSans-Light',
                            ),
                            filled: true,
                            fillColor: thirdColorSecondary,
                          ),
                          maxLines: 3,
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
                                isClicked = 0;
                              });
                            },
                          ),
                          ButtonWithText(
                            widthOfButton: width * (139 / 1920),
                            heightOfButton: width * (84 / 1920),
                            text: 'confirm',
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
                  color: Colors.white,
                  child: Center(
                    child: ButtonWithText(
                      widthOfButton: width * (261 / 1920),
                      heightOfButton: width * (84 / 1920),
                      text: 'cancel the deal',
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
