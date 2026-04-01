import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/property_card/property_card.dart';
import 'package:untitled1/core/widgets/property_photos_shower/property_photos_shower_widget.dart';

class ExpandedPropertyCardWithPhotos extends StatelessWidget {
  const ExpandedPropertyCardWithPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (1518 / 1920),
      height: width * (951 / 1920),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PropertyCard(),
          PropertyPhotosShowerWidget(isPrimaryPropertyPhotos: true),
        ],
      ),
    );
  }
}
