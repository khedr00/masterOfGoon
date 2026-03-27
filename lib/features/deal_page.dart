import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/client_chat/client_chat_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/avoidances_only_body.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_only_body.dart';
import 'package:untitled1/core/widgets/simple_deal_info_card/simple_deal_info_card.dart';

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
        child: Row(
          children: [
            Column(
              children: [
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
                SimpleDealInfoCard(
                  dealStage: 'Negotiation',
                  dealTitle: 'Mountain Villa Deal',
                  dealId: '53462',
                  dealDate: '2/2/2026',
                  priceRange: '2000,000 - 2500,000',
                  successRate: '55%',
                ),
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
            ClientChatWidget(),
          ],
        ),
      ),
    );
  }
}
