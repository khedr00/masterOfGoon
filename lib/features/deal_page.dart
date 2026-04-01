import 'package:flutter/material.dart';
import 'package:untitled1/core/modules/schedule-models/schedule_deal_note.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/client_chat/client_chat_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_actions/deal_actions_widget.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/avoidances_only_body.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_only_body.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/notes_variations/deal_note_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/property_card/property_card.dart';
import 'package:untitled1/core/widgets/simple_deal_info_card/simple_deal_info_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/Deals_only_schedule_widget/deals_notes_widget.dart';

class DealPage extends StatefulWidget {
  const DealPage({super.key});

  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.only(top: width * (30 / 1920)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: width * (1000 / 1920),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: width * (30 / 1920)),
                      ButtonWithImage(
                        image: 'assets/images/Return.png',
                        widthOfButton: width * (60 / 1920),
                        heightOfButton: width * (60 / 1920),
                        widthOfImage: width * (50 / 1920),
                        heightOfImage: width * (50 / 1920),
                        buttonAction: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: width * (30 / 1920)),
                      SimpleDealInfoCard(
                        dealStage: 'Negotiation',
                        dealTitle: 'Mountain Villa Deal',
                        dealId: '53462',
                        dealDate: '2/2/2026',
                        priceRange: '2000,000 - 2500,000',
                        successRate: '55%',
                      ),
                      SizedBox(height: width * (30 / 1920)),
                      GeneralTabableCard(
                        tabs: [
                          TabOfTabableCard(
                            tabName: 'liked stuff',
                            tabColor: fifthColorPrimaryGreen,
                            bodyOfTheTab: LikedOnlyBody(),
                          ),
                          TabOfTabableCard(
                            tabName: 'Avoidances',
                            tabColor: sixthColorPrimaryRed,
                            bodyOfTheTab: AvoidancesOnlyBody(),
                          ),
                        ],
                        fullCardWidth: width * (403 / 1920),
                        fullCardHeight: width * (500 / 1920),
                      ),
                    ],
                  ),
                ),
                ClientChatWidget(),
                GeneralTabableCard(
                  tabs: [
                    TabOfTabableCard(
                      tabName: 'schedule',
                      tabColor: thirdColorPrimary,
                      bodyOfTheTab: DealsOnlyScheduleWidget(
                        forDealPage: true,
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
                    TabOfTabableCard(
                      tabName: 'Actions',
                      tabColor: primaryColor,
                      bodyOfTheTab: DealActionsWidget(),
                    ),
                    TabOfTabableCard(
                      tabName: 'Property',
                      tabColor: fourthColorPrimaryBrown,
                      bodyOfTheTab: Container(
                        width: width * (881 / 1920),
                        height: width * (910 / 1920),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (30 / 1920)),
                            bottomLeft: Radius.circular(width * (30 / 1920)),
                            bottomRight: Radius.circular(width * (30 / 1920)),
                          ),
                        ),
                        child: Center(child: PropertyCard()),
                      ),
                    ),
                  ],
                  fullCardWidth: width * (895 / 1920),
                  fullCardHeight: width * (910 / 1920),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
