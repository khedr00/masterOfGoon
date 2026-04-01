import 'package:flutter/material.dart';
import 'package:untitled1/features/property_feature/widgets/expanded_property_card_with_photos.dart';
import 'package:untitled1/features/property_feature/widgets/property_mini_cards_viewer/property_mini_cards_viewer.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [PropertyMiniCardsViewer(), ExpandedPropertyCardWithPhotos()],
      ),
    );
  }
}
