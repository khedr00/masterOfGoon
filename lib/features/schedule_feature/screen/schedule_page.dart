import 'package:flutter/material.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_deal_note.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_note.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/custom_text_field/custom_text_field.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/personal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/personal_and_deals_schedule_widget.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool _isClicked = false;
  DateTime _dateTime = DateTime.now();
  String _dayName = '';

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
          _dayName = getDayNameFromDateTime(_dateTime);
          _isClicked = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (24 / 1920),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width * (20 / 1920)),
                          child: CustomTextField(
                            onChanged: (value) {},
                            hintText: 'Enter Title',
                            widthOfTextField: debugWidth / 1.2,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: width * (10 / 1920),
                            bottom: width * (30 / 1920),
                          ),
                          child: CustomTextField(
                            onChanged: (value) {},
                            hintText: 'Enter Description',
                            widthOfTextField: debugWidth / 1.2,
                          ),
                        ),
                        Text(
                          'Attatch to a deal :',
                          style: TextStyle(
                            color: Colors.black,
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
                            onChanged: (value) {},
                            hintText: 'ID',
                            widthOfTextField: debugWidth / 3,
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
                              buttonAction: () {
                                setState(() {
                                  _isClicked = false;
                                });
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
              fullHeight: width * (820 / 1920),
              personalAndDealsNotes: [
                PersonalNoteWidget(
                  scheduleNote: ScheduleNote(
                    id: 1,
                    employeeId: 1,
                    date: '2/2/2026',
                    time: '6:00',
                    title: '1',
                    description:
                        "don't forget about theasdfaefaewfewfawefasfasdf pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '2',
                    description: 'akucasdfasdfasdfasdfasdfdgl',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '3',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '4',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '5',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '6',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '7',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '8',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '9',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '10',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '11',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '12',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
                DealNoteWidget(
                  scheduleDealNote: ScheduleDealNote(
                    id: 1,
                    employeeId: 1,
                    date: '8798',
                    time: '2:00',
                    title: '13',
                    description:
                        'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
                    dealId: 1,
                    dealName: 'Request to Buy Property Homs City',
                    propertyNameCode: 'V_234',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
