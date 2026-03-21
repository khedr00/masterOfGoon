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
    );
  }
}
