import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/get_10_property_cards.dart';
import 'package:untitled1/back_end_test/properties/modules/prpoperty_card_info/property_card_module_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/apartment_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/hall_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/house_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/store_mini_card.dart';
import 'package:untitled1/features/property_feature/widgets/property_cards/villa_mini_card.dart';

class PropertyMiniCardsViewer extends StatefulWidget {
  const PropertyMiniCardsViewer({super.key});

  @override
  State<PropertyMiniCardsViewer> createState() =>
      _PropertyMiniCardsViewerState();
}

class _PropertyMiniCardsViewerState extends State<PropertyMiniCardsViewer> {
  final ScrollController _controller = ScrollController();
  final List<dynamic> _listOfPropertyCardsInfo = [];
  bool _isLoading = false;
  int numberOfPastCalles = -1;

  void _getTenPropertyCardsInfo() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      numberOfPastCalles++;
    });
    List<PropertyCardModuleInfo> listOfPropertyCardsInfo =
        await getTenPropertyCards(
          role: 'sales',
          numberOfPastCalles: numberOfPastCalles,
        );

    setState(() {
      _isLoading = false;
      _listOfPropertyCardsInfo.addAll(listOfPropertyCardsInfo);
    });
  }

  void _getTenPropertyCardsInfoAgain() {
    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent &&
          !_isLoading) {
        _getTenPropertyCardsInfo();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getTenPropertyCardsInfo();
    _getTenPropertyCardsInfoAgain();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (_listOfPropertyCardsInfo.isEmpty) {
      return Container(
        color: backGroundColor,
        child: Center(child: CircularProgressIndicator()),
      );
    }
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
              controller: _controller,
              itemCount: _listOfPropertyCardsInfo.length + (_isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int i) {
                if (i == _listOfPropertyCardsInfo.length) {
                  return Padding(
                    padding: EdgeInsets.all(width * (15 / 1920)),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                switch (_listOfPropertyCardsInfo[i].propertyType) {
                  case 'villa':
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (20 / 1920),
                      ),
                      child: GestureDetector(
                        child: VillaMiniCard(
                          villaCardModuleInfo: _listOfPropertyCardsInfo[i],
                        ),
                      ),
                    );
                  case 'house':
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (20 / 1920),
                      ),
                      child: GestureDetector(
                        child: HouseMiniCard(
                          houseCardModuleInfo: _listOfPropertyCardsInfo[i],
                        ),
                      ),
                    );
                  case 'hall':
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (20 / 1920),
                      ),
                      child: GestureDetector(
                        child: HallMiniCard(
                          hallCardModuleInfo: _listOfPropertyCardsInfo[i],
                        ),
                      ),
                    );
                  case 'store':
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (20 / 1920),
                      ),
                      child: GestureDetector(
                        child: StoreMiniCard(
                          storeCardModuleInfo: _listOfPropertyCardsInfo[i],
                        ),
                      ),
                    );
                  case 'apartment':
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (20 / 1920),
                      ),
                      child: GestureDetector(
                        child: ApartmentMiniCard(
                          apartmentCardModuleInfo: _listOfPropertyCardsInfo[i],
                        ),
                      ),
                    );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
