import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/personal_and_deals_schedule_info.dart/schedule_deal_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/note_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return NoteWidget(
      scheduleNote: widget.scheduleDealNote,

      clockColor: widget.scheduleDealNote.title == "MEETING"
          ? Colors.red
          : (themeProvider.isDarkMode
                ? darkThirdColorSecondary
                : thirdColorSecondary),

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

        child: GestureDetector(
          onTap: () async {
            await Clipboard.setData(
              ClipboardData(text: widget.scheduleDealNote.dealId.toString()),
            );

            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('ID copied to clipboard'),
                duration: Duration(seconds: 2),
              ),
            );
          },

          child: SizedBox(
            width: width * (35 / 1920),
            height: width * (30 / 1920),
            child: Image.asset('assets/images/Handshake.png'),
          ),
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
                      color: themeProvider.isDarkMode
                          ? const Color(0xff757575)
                          : const Color(0xff545454),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width * (10 / 1920)),
                        bottomLeft: Radius.circular(width * (10 / 1920)),
                      ),
                    ),

                    child: Padding(
                      padding: EdgeInsets.all(width * (5 / 1920)),
                      child: Center(
                        child: Text(
                          'ID: ${widget.scheduleDealNote.dealId.toString()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-SemiBold',
                            fontSize: width * (14 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    width: width * (23 / 1920),
                    height: width * (100 / 1920),
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? const Color(0xff757575)
                          : const Color(0xff545454),
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
          : const SizedBox(),
    );
  }
}
