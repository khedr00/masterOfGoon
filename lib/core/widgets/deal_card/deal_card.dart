import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/deal_card_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_deal_satge_section.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_client_section.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_property_section.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key, required this.dealCardInfo});
  final DealCardInfo dealCardInfo;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (939 / 1920),
          height: width * (246 / 1920),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(width * (10 / 1920)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DealCardDealSatgeSection(
                    dealStage: dealCardInfo.dealStage.toString(),
                  ),
                  DealCardClientSection(
                    clientName: dealCardInfo.clientName,
                    clientPhoto: dealCardInfo.clientPhoto,
                    lastMessage: 'I will call you back later',
                    timePassed: '39',
                  ),
                ],
              ),
              DealCardPropertySection(
                dealDate: dealCardInfo.startingDate,
                dealId: dealCardInfo.id.toString(),
                propertyPrimaryImage: 'assets/images/test_photos/1.jpg',
                propertyType: 'villa',
                propertyPrice: 30000,
                propertySimpleDescription:
                    'Furnished Apartment with pool and 2 balconies ',
                propertyAddress: 'homs_shien',
              ),
            ],
          ),
        ),
        // القطعة الفوقانية بالنص - العنوان ونسبة النجاح
        Positioned(
          left: width * (136 / 1920),
          top: 0,
          width: width * (608 / 1920),
          height: width * (80 / 1920),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * (10 / 1920)),
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
              color: backGroundColor,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    top: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (452 / 1920),
                    height: width * (62 / 1920),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        dealCardInfo.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    right: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (129 / 1920),
                    height: width * (71 / 1920),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(width * (10 / 1920)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        ' Success Rate :\n${dealCardInfo.successProbability.toString()} %',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans-ExtraBold',
                          fontSize: width * (16 / 1920),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
