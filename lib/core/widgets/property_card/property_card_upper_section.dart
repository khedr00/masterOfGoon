import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/properties/modules/property_info_with_primary_images/property_info_with_primary_images.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/property_card/tabable_property_icon.dart';

class PropertyCardUpperSection extends StatelessWidget {
  const PropertyCardUpperSection({
    super.key,
    required this.propertyInfo,
    required this.outDoorPlaces,
    required this.hasMoreThanOneFloor,
    required this.floor,
    required this.elevator,
    required this.buildingBarking,
    required this.storeFront,
  });
  final PropertyInfoWithPrimaryImages propertyInfo;
  final List<String> outDoorPlaces;
  final bool hasMoreThanOneFloor;
  final int floor;
  final bool elevator;
  final bool buildingBarking;
  final Widget storeFront;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (866 / 1920),
          height: width * (638 / 1920),
          color: Colors.white,
          child: Center(
            child: Container(
              width: width * (846 / 1920),
              height: width * (618 / 1920),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width * (5 / 1920)),
                color: fourthColorSecondaryLightBrown,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: width * (85 / 1920),
                    child: Row(
                      children: [
                        // فيلر اول من فوق عاليسار
                        Container(
                          width: width * (652 / 1920),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        // for sale
                        SizedBox(
                          width: width * (194 / 1920),
                          height: width * (85 / 1920),
                          child: Center(
                            child: Text(
                              'for Sale',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NunitoSans-ExtraBold',
                                fontSize: width * (32 / 1920),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (151 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (137 / 1920),
                          color: Colors.white,
                        ),
                        // شرح العقار الزيادة
                        SizedBox(
                          width: width * (709 / 1920),
                          child: Center(
                            child: Text(
                              propertyInfo.fullPropertyDescription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'NunitoSans-Medium',
                                fontSize: width * (28 / 1920),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (154 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (215 / 1920),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        // هون المعلومات الأساسية اللي جاي بالنص
                        SizedBox(
                          width: width * (631 / 1920),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TabablePropertyIcon(
                                    image: 'assets/images/Room.png',
                                    text:
                                        '${propertyInfo.numberOfRooms.toString()} Rooms',
                                  ),
                                  outDoorPlaces.isEmpty
                                      ? SizedBox()
                                      : TabablePropertyIcon(
                                          image: 'assets/images/Garden.png',
                                          text: 'out doors',
                                        ),
                                  TabablePropertyIcon(
                                    image: 'assets/images/Paint Roller.png',
                                    text: 'Painting',
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  elevator
                                      ? TabablePropertyIcon(
                                          image:
                                              'assets/images/Elevator Doors.png',
                                          text: 'Elevator',
                                        )
                                      : SizedBox(),
                                  buildingBarking
                                      ? TabablePropertyIcon(
                                          image: 'assets/images/Parking.png',
                                          text: 'Building parking',
                                        )
                                      : SizedBox(),
                                  GestureDetector(child: storeFront),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // هاد افيه معلومات نهائي
                  SizedBox(
                    height: width * (35 / 1920),
                    child: Row(
                      children: [
                        Container(
                          width: width * (215 / 1920),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                        SizedBox(width: width * (327 / 1920)),
                        Container(
                          width: width * (304 / 1920),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width * (5 / 1920)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * (193 / 1920),
                    child: Row(
                      children: [
                        // هون الأوتدور وهيك
                        SizedBox(
                          width: width * (542 / 1920),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TabablePropertyIcon(
                                    image: 'assets/images/Square Border.png',
                                    text: '${propertyInfo.sqft.toString()}M',
                                  ),
                                  TabablePropertyIcon(
                                    image: 'assets/images/Closet.png',
                                    text: propertyInfo.furnitureState,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TabablePropertyIcon(
                                    image: propertyInfo.avaliableInternet
                                        ? 'assets/images/Wi-Fi.png'
                                        : 'assets/images/Wi-Fi.png',
                                    text: propertyInfo.avaliableInternet
                                        ? 'Wi-Fi'
                                        : 'no Wi-Fi',
                                  ),
                                  TabablePropertyIcon(
                                    image: hasMoreThanOneFloor
                                        ? 'assets/images/Stairs Up.png'
                                        : 'assets/images/floor.png',
                                    text: hasMoreThanOneFloor
                                        ? '$floor floors'
                                        : '${floor}d floor',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: width * (304 / 1920),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: width * (137 / 1920),
            height: width * (58 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * (50 / 1920),
                  height: width * (50 / 1920),
                  child: Image.asset(
                    propertyInfo.getpropertyIcon(propertyInfo.propertyType),
                  ),
                ),
                Text(
                  propertyInfo.propertyType,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (24 / 1920),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (67 / 1920),
          left: width * (10 / 1920),
          child: Container(
            width: width * (127 / 1920),
            height: width * (178 / 1920),
            decoration: BoxDecoration(
              color: fourthColorSecondaryLightBrown,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * (90 / 1920),
                  height: width * (90 / 1920),
                  child: Image.asset(
                    'assets/images/Map with marked location.png',
                  ),
                ),
                Text(
                  propertyInfo.address,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (18 / 1920),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (255 / 1920),
          left: 0,
          child: Container(
            width: width * (215 / 1920),
            height: width * (169 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
                bottomRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/Price Tag USD.png'),
                    ),
                    Text(
                      '${propertyInfo.leastSellPrice} \$',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-ExtraBold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/Split Money.png'),
                    ),
                    Text(
                      '${propertyInfo.fakePrice} \$',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-LightItalic',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset(
                        propertyInfo.isAvaliable
                            ? 'assets/images/Check Mark.png'
                            : 'assets/images/Cancel.png',
                      ),
                    ),
                    Text(
                      propertyInfo.isAvaliable ? 'avaliable' : 'not avaliable',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Medium',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (410 / 1920),
          right: 0,
          child: Container(
            width: width * (304 / 1920),
            height: width * (218 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (10 / 1920)),
                bottomLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Near By :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (28 / 1920),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width * (5 / 1920)),
                  child: SizedBox(
                    height: width * (175 / 1920),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 3,
                        crossAxisCount: 2,
                      ),
                      itemCount: propertyInfo.nearByPlaces.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: width * (150 / 1920),
                          child: Center(
                            child: Text(
                              '${propertyInfo.nearByPlaces[index].nearbyPlace} ${propertyInfo.nearByPlaces[index].destance.toString()}M',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NunitoSans-Regular',
                                fontSize: width * (20 / 1920),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width * (10 / 1920),
          left: width * (147 / 1920),
          child: Container(
            width: width * (390 / 1920),
            height: width * (75 / 1920),
            decoration: BoxDecoration(
              color: fourthColorSecondaryLightBrown,
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: Center(
              child: Text(
                propertyInfo.simplePropertyDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'NunitoSans-Black',
                  fontSize: width * (36 / 1920),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: width * (547 / 1920),
          child: Container(
            width: width * (105 / 1920),
            height: width * (85 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(width * (10 / 1920)),
                bottomLeft: Radius.circular(width * (10 / 1920)),
              ),
            ),
            child: Center(
              child: Text(
                propertyInfo.nameCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'NunitoSans-BlackItalic',
                  fontSize: width * (28 / 1920),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
