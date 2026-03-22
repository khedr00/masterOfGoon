import 'package:flutter/material.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/note_widget.dart';

class PersonalNoteWidget extends StatelessWidget {
  const PersonalNoteWidget({super.key, required this.scheduleNote});
  final ScheduleNote scheduleNote;

  @override
  Widget build(BuildContext context) {
    return NoteWidget(
      scheduleNote: scheduleNote,
      clockColor: thirdColorSecondary,
      handsIcon: SizedBox(),
      isHoverd: false,
      handIconHoverWidget: SizedBox(),
    );
  }
}
