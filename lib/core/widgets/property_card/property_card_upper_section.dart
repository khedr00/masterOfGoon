import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/property_card/tabable_property_icon.dart';

class PropertyCardUpperSection extends StatelessWidget {
  const PropertyCardUpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                    // ايقونة الأفيلابل
                    SizedBox(
                      width: width * (194 / 1920),
                      child: SizedBox(
                        width: width * (85 / 1920),
                        height: width * (85 / 1920),
                        child: Image.asset('assets/images/Check Mark.png'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * (151 / 1920),
                child: Row(
                  children: [
                    Container(width: width * (137 / 1920), color: Colors.white),
                    // شرح العقار الزيادة
                    SizedBox(
                      width: width * (709 / 1920),
                      child: Center(
                        child: Text(
                          'A clean and comfortable apartment with good space and natural light. Close to shops and public transportation.',
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TabablePropertyIcon(
                                image: 'assets/images/House.png',
                                text: '380 M',
                              ),
                              TabablePropertyIcon(
                                image: 'assets/images/Sofa.png',
                                text: '6 Rooms',
                              ),
                              TabablePropertyIcon(
                                image: 'assets/images/Star.png',
                                text: '9.2',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TabablePropertyIcon(
                                image: 'assets/images/Basement.png',
                                text: '100 M',
                              ),
                              TabablePropertyIcon(
                                image: 'assets/images/Stairs Up.png',
                                text: '3 floors',
                              ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TabablePropertyIcon(
                                image: 'assets/images/Parking.png',
                                text: '2 Cars',
                              ),
                              TabablePropertyIcon(
                                image: 'assets/images/Balcony.png',
                                text: '3 Balconys',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TabablePropertyIcon(
                                image: 'assets/images/Garden.png',
                                text: 'Garden',
                              ),
                              TabablePropertyIcon(
                                image: 'assets/images/Pool.png',
                                text: '3M Pool',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(width: width * (304 / 1920), color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
