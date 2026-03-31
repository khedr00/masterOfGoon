import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/property_card/property_card_lower_section.dart';
import 'package:untitled1/core/widgets/property_card/property_card_upper_section.dart';

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (866 / 1920),
          height: width * (885 / 1920),
          color: backGroundColor,
          child: Column(
            children: [
              // اول قسم اساسي من فوق
              PropertyCardUpperSection(),
              // تاني قسم رئيسي من تحت
              PropertyCardLowerSection(),
            ],
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
                  child: Image.asset('assets/images/Mansion.png'),
                ),
                Text(
                  'villa',
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
                  'Tartous,Syria,Al-Qadmous',
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
                      '120000-130000 \$',
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
                      '14000 \$',
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
                      child: Image.asset('assets/images/Closet.png'),
                    ),
                    Text(
                      'Furnished',
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
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (32 / 1920),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/School.png'),
                    ),
                    Text(
                      'School',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (24 / 1920),
                      ),
                    ),
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/ph.png'),
                    ),
                    Text(
                      'Pharmacy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Regular',
                        fontSize: width * (24 / 1920),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width * (30 / 1920),
                      height: width * (30 / 1920),
                      child: Image.asset('assets/images/Stall.png'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * (10 / 1920)),
                      child: Text(
                        'Market',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans-Regular',
                          fontSize: width * (24 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: width * (10 / 1920),
          child: Container(
            width: width * (168 / 1920),
            height: width * (143 / 1920),
            decoration: BoxDecoration(
              color: fourthColorPrimaryBrown,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
              ),
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
                'Mountain View Villa',
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
                'V-265',
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
