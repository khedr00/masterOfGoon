import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_photos_shower/property_photos_shower_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ExpandedPropertyCardWithPhotos extends StatelessWidget {
  const ExpandedPropertyCardWithPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (1518 / 1920),
      height: width * (951 / 1920),
      decoration: BoxDecoration(
        color: getCardColor(themeProvider.isDarkMode),
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PropertyCard(propertyId: '1'),
          PropertyPhotosShowerWidget(isPrimaryPropertyPhotos: true),
        ],
      ),
    );
  }
}
