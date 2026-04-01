import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/features/property_feature/widgets/property_mini_cards_viewer/property_mini_card.dart';

class PropertyMiniCardsViewer extends StatelessWidget {
  const PropertyMiniCardsViewer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (381 / 1920),
      height: width * (951 / 1920),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: width * (30 / 1920)),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (28 / 1920),
                    right: width * (28 / 1920),
                  ),
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
          ),
          SizedBox(
            height: width * (850 / 1920),

            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: width * (20 / 1920)),
                  child: GestureDetector(child: PropertyMiniCard()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
