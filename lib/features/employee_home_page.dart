import 'package:flutter/material.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_deal_note.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_note.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/personal_note_widget.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  List<Widget> dealList = [
    DealCard(),
    DealCard(),
    DealCard(),
    DealCard(),
    DealCard(),
    DealCard(),
  ];
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Column(
        children: [
          PersonalNoteWidget(
            scheduleNote: ScheduleNote(
              id: 1,
              employeeId: 1,
              date: '2/2/2026',
              time: '6:00',
              title: 'call the',
              description:
                  "don't forget about the pool and the garden jhjdh jpap8eq[fqvm [opepifqew [AP[qw--jdOAISSIDUSDF]]]]",
            ),
          ),
          DealNoteWidget(
            scheduleDealNote: ScheduleDealNote(
              id: 1,
              employeeId: 1,
              date: '8798',
              time: '2:00',
              title: 'khedrissakhedri',
              description: 'akudgl',
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
              title: 'MEETING',
              description:
                  'akudglajhdgca,vhscjhsgcljaytxc,jve,dc,vjgv,,uzVlgscvJHC',
              dealId: 1,
              dealName: 'Request to Buy Property Homs City',
              propertyNameCode: 'V_234',
            ),
          ),
        ],
      ),
      // SingleChildScrollView(
      //   physics: NeverScrollableScrollPhysics(),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       PageHeader(),
      //       Row(
      //         children: [
      //           SizedBox(width: width * (28 / 1920)),
      //           ButtonWithImage(
      //             image: 'assets/images/Slider.png',
      //             widthOfButton: width * (60 / 1920),
      //             heightOfButton: width * (40 / 1920),
      //             heightOfImage: width * (30 / 1920),
      //             widthOfImage: width * (30 / 1920),
      //           ),
      //           SizedBox(width: width * (28 / 1920)),
      //           ButtonWithImage(
      //             image: 'assets/images/Search.png',
      //             widthOfButton: width * (60 / 1920),
      //             heightOfButton: width * (40 / 1920),
      //             heightOfImage: width * (30 / 1920),
      //             widthOfImage: width * (30 / 1920),
      //           ),
      //         ],
      //       ),
      //       SizedBox(height: width * (36 / 1920)),
      //       Row(
      //         children: [
      //           SizedBox(
      //             height: width * (864 / 1920),
      //             width: width * (939 / 1920),
      //             child: ListView.builder(
      //               itemCount: dealList.length,
      //               itemBuilder: (BuildContext context, int i) {
      //                 return Padding(
      //                   padding: EdgeInsets.only(
      //                     bottom: width * (28 / 1920),
      //                   ),
      //                   child: dealList[i],
      //                 );
      //               },
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
