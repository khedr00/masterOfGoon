import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_section1.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_section2.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card_section3.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key});

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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [DealCardSection1(), DealCardSection2()],
              ),
              DealCardSection3(),
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
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
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
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
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
                        bottom: Radius.circular(10),
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
