import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/get_10_property_cards.dart';
import 'package:untitled1/back_end_test/properties/modules/property_card_module_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/widgets/expanded_property_card_with_photos.dart';
import 'package:untitled1/features/property_feature/widgets/property_mini_cards_viewer/property_mini_cards_viewer.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  List<PropertyCardModuleInfo> _listOfPropertyCardsInfo = [];
  void _getTenPropertyCardsInfo() async {
    List<PropertyCardModuleInfo> listOfPropertyCardsInfo =
        await getTenPropertyCards(role: 'sales');
    setState(() {
      _listOfPropertyCardsInfo = listOfPropertyCardsInfo;
    });
  }

  @override
  void initState() {
    _getTenPropertyCardsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;

    if (_listOfPropertyCardsInfo.isEmpty) {
      return Scaffold(
        backgroundColor: backGroundColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return GestureDetector(
      onTap: () {
        print(_listOfPropertyCardsInfo[0].address);
      },
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PropertyMiniCardsViewer(),
            ExpandedPropertyCardWithPhotos(),
          ],
        ),
      ),
    );
  }
}
