import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_note.dart';
import 'package:untitled1/core/widgets/constants.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    super.key,
    required this.scheduleNote,
    required this.handsIcon,
    required this.clockColor,
    required this.isHoverd,

    required this.handIconHoverWidget,
  });
  final ScheduleNote scheduleNote;
  final Widget handsIcon;
  final Color clockColor;
  final bool isHoverd;
  final Widget handIconHoverWidget;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width * (322 / 1920),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: width * (24 / 1920),
                width: width * (322 / 1920),
                color: Colors.white,
              ),
              Container(
                width: width * (322 / 1920),
                decoration: BoxDecoration(
                  color: thirdColorSecondary,
                  borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      color: thirdColorSecondary,
                      spreadRadius: width * (2 / 1920),
                      blurRadius: width * (3 / 1920),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: width * (79 / 1920)),
                        SizedBox(
                          width: width * (242 / 1920),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * (195 / 1920),
                                child: Center(
                                  child: Text(
                                    widget.scheduleNote.title,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'NunitoSans-Bold',
                                      fontSize: width * (26 / 1920),
                                    ),
                                  ),
                                ),
                              ),

                              widget.handsIcon,
                              SizedBox(width: width * (12 / 1920)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width * (10 / 1920)),
                    Padding(
                      padding: EdgeInsets.all(width * (10 / 1920)),
                      child: Text(
                        widget.scheduleNote.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-Light',
                          fontSize: width * (24 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: width * (14 / 1920),
          child: Container(
            width: width * (65 / 1920),
            height: width * (65 / 1920),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Center(
              child: Container(
                width: width * (53 / 1920),
                height: width * (53 / 1920),
                decoration: BoxDecoration(
                  color: widget.clockColor,
                  borderRadius: BorderRadius.circular(1000),
                  boxShadow: [
                    BoxShadow(
                      color: widget.clockColor,
                      spreadRadius: width * (3 / 1920),
                      blurRadius: width * (2 / 1920),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.scheduleNote.time,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (22 / 1920),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        widget.handIconHoverWidget,
      ],
    );
  }
}
