import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/client_chat/client_chat_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_actions/deal_actions_widget.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/avoidances_only_body.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_only_body.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/property_card/property_card.dart';
import 'package:untitled1/core/widgets/simple_deal_info_card/simple_deal_info_card.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealPage extends StatefulWidget {
  const DealPage({super.key});
  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
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
                            tabName: 'Preferences',
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
                      tabColor: themeProvider.isDarkMode ? darkThirdColorPrimary : thirdColorPrimary,
                      bodyOfTheTab: DealsOnlyScheduleWidget(
                        dealId: 1,
                        forDealPage: true,
                      ),
                    ),
                    TabOfTabableCard(
                      tabName: 'Actions',
                      tabColor: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
                      bodyOfTheTab: DealActionsWidget(),
                    ),
                    TabOfTabableCard(
                      tabName: 'Property',
                      tabColor: fourthColorPrimaryBrown,
                      bodyOfTheTab: Container(
                        width: width * (881 / 1920),
                        height: width * (910 / 1920),
                        decoration: BoxDecoration(
                          color: getCardColor(themeProvider.isDarkMode),
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
