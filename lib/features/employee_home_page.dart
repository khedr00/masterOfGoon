import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/modules/deal/deal.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_deal_note.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_note.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/all_and_deals_only_button.dart';
import 'package:untitled1/core/widgets/buttons/double_button/new_and_ongoing_deals_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/core/widgets/header/page_header.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/personal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/Deals_only_schedule_widget/deals_notes_widget.dart';
// import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/Deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/personal_and_deals_schedule_widget.dart';
import 'package:untitled1/features/deal_page.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  List<Widget> dealList = [
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
    DealCard(
      deal: Deal(
        id: 1,
        propertyId: 2,
        clientId: 3,
        employeeId: 4,
        title: 'the mountain vella deal',
        dealStage: DealStage.negotiation,
        successProbability: 23,
        startingDate: '2/2/2026',
        notes: [
          'hqjwegfkuqefglidga;sdjg;auig',
          'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final allAndDealsOnlyProvider = Provider.of<AllAndDealsOnlyProvider>(
      context,
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PageHeader(),
            Row(
              children: [
                SizedBox(width: width * (28 / 1920)),
                NewAndOngoingDealsButton(),
                SizedBox(width: width * (28 / 1920)),
                ButtonWithImage(
                  image: 'assets/images/Slider.png',
                  widthOfButton: width * (60 / 1920),
                  heightOfButton: width * (40 / 1920),
                  heightOfImage: width * (30 / 1920),
                  widthOfImage: width * (30 / 1920),
                ),
                SizedBox(width: width * (28 / 1920)),
                ButtonWithImage(
                  image: 'assets/images/Search.png',
                  widthOfButton: width * (60 / 1920),
                  heightOfButton: width * (40 / 1920),
                  heightOfImage: width * (30 / 1920),
                  widthOfImage: width * (30 / 1920),
                ),
                SizedBox(width: width * (660 / 1920)),
                AllAndDealsOnlyButton(),
              ],
            ),
            SizedBox(height: width * (36 / 1920)),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * (28 / 1920)),
                  child: SizedBox(
                    height: width * (794 / 1920),
                    width: width * (939 / 1920),
                    child: ListView.builder(
                      itemCount: dealList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: width * (28 / 1920)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DealPage(),
                                ),
                              );
                            },
                            child: dealList[i],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Padding(
                  padding: EdgeInsets.only(right: width * (28 / 1920)),
                  child: allAndDealsOnlyProvider.allAreClicked
                      ? PersonalAndDealsScheduleWidget(
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
                        )
                      : DealsOnlyScheduleWidget(
                          forDealPage: false,
                          dealNotes: [
                            'hqjwegfkuqefglidga;sdjg;auig',
                            'jhdvgwiueydjhdguytustdvckdshdcutsdtcsdvcshcd',
                          ],
                          apoitmentsNotes: [
                            DealsNotesWidget(
                              dateTime: DateTime.now(),
                              dealApoitmentNotes: [
                                DealNoteWidget(
                                  scheduleDealNote: ScheduleDealNote(
                                    id: 1,
                                    employeeId: 1,
                                    date: '8798',
                                    time: '2:00',
                                    title: '2',
                                    description: 'akucasdfasdfasdfasdfasdfdgl',
                                    dealId: 1,
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
                                    propertyNameCode: 'V_234',
                                  ),
                                ),
                              ],
                            ),
                            DealsNotesWidget(
                              dateTime: DateTime.now(),
                              dealApoitmentNotes: [
                                DealNoteWidget(
                                  scheduleDealNote: ScheduleDealNote(
                                    id: 1,
                                    employeeId: 1,
                                    date: '8798',
                                    time: '2:00',
                                    title: '2',
                                    description: 'akucasdfasdfasdfasdfasdfdgl',
                                    dealId: 1,
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
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
                                    dealName:
                                        'Request to Buy Property Homs City',
                                    propertyNameCode: 'V_234',
                                  ),
                                ),
                              ],
                            ),
                          ],
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
