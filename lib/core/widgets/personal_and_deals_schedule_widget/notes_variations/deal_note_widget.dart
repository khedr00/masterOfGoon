import 'package:flutter/material.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_deal_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/note_widget.dart';

class DealNoteWidget extends StatefulWidget {
  const DealNoteWidget({super.key, required this.scheduleDealNote});
  final ScheduleDealNote scheduleDealNote;

  @override
  State<DealNoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<DealNoteWidget> {
  bool isHoverd = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return NoteWidget(
      scheduleNote: widget.scheduleDealNote,
      clockColor: widget.scheduleDealNote.title == "MEETING"
          ? Colors.red
          : thirdColorSecondary,
      handsIcon: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHoverd = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHoverd = false;
          });
        },
        child: SizedBox(
          width: width * (35 / 1920),
          height: width * (30 / 1920),
          child: Image.asset('assets/images/Handshake.png'),
        ),
      ),
      isHoverd: isHoverd,
      handIconHoverWidget: isHoverd
          ? Positioned(
              left: width * (135 / 1920),
              child: Row(
                children: [
                  Container(
                    width: width * (117 / 1920),
                    height: width * (100 / 1920),
                    decoration: BoxDecoration(
                      color: Color(0xff545454),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width * (10 / 1920)),
                        bottomLeft: Radius.circular(width * (10 / 1920)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * (2 / 1920),
                            vertical: width * (5 / 1920),
                          ),
                          child: Text(
                            widget.scheduleDealNote.dealName,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans-Light',
                              fontSize: width * (12 / 1920),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Text(
                          'ID: ${widget.scheduleDealNote.dealId.toString()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-SemiBold',
                            fontSize: width * (14 / 1920),
                          ),
                        ),
                        Text(
                          widget.scheduleDealNote.propertyNameCode,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-SemiBold',
                            fontSize: width * (14 / 1920),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * (23 / 1920),
                    height: width * (100 / 1920),
                    decoration: BoxDecoration(
                      color: Color(0xff545454),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.elliptical(
                          width * (23 / 1920),
                          width * (100 / 1920),
                        ),
                        bottomRight: Radius.elliptical(
                          width * (23 / 1920),
                          width * (100 / 1920),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
