import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/deal_card_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Widget> dealList = [
    DealCard(
      dealCardInfo: DealCardInfo(
        id: 1,
        propertyId: 2,
        clientId: 3,
        title: 'the mountain vella deal',
        dealStage: 'negotiation',
        successProbability: 23,
        startingDate: '2/2/2026',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: width * (30 / 1920)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(width * (28 / 1920)),
                  child: ButtonWithImage(
                    image: 'assets/images/Slider.png',
                    widthOfButton: width * (60 / 1920),
                    heightOfButton: width * (40 / 1920),
                    heightOfImage: width * (30 / 1920),
                    widthOfImage: width * (30 / 1920),
                  ),
                ),
                ButtonWithImage(
                  image: 'assets/images/Search.png',
                  widthOfButton: width * (60 / 1920),
                  heightOfButton: width * (40 / 1920),
                  heightOfImage: width * (30 / 1920),
                  widthOfImage: width * (30 / 1920),
                ),
              ],
            ),
            SizedBox(
              height: height,
              child: GridView.builder(
                padding: EdgeInsets.only(left: width * (15 / 1920)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3,
                  crossAxisCount: 2,
                ),
                itemCount: dealList.length,
                itemBuilder: (context, index) {
                  return dealList[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
