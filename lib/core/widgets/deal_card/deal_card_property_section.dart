import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCardPropertySection extends StatelessWidget {
  const DealCardPropertySection({
    super.key,
    required this.propertyType,
    required this.price,
    required this.simplePropertyDescription,
    required this.address,
    required this.dealDate,
    required this.dealId,
    required this.propertyImage,
  });
  final String dealDate;
  final String dealId;
  final String propertyType;
  final String price;
  final Image propertyImage;
  final String simplePropertyDescription;
  final String address;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            // فيلير لمحل الستاك مشان ما تجي فيه عناصر و تختفي تحت الستاك
            Container(
              width: width * (413 / 1920),
              height: width * (79 / 1920),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
            ),
            SizedBox(
              width: width * (193 / 1920),
              height: width * (79 / 1920),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    dealDate,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (16 / 1920),
                    ),
                  ),
                  Text(
                    'ID : $dealId',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NunitoSans-MediumItalic',
                      fontSize: width * (16 / 1920),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: width * (305 / 1920),
              height: width * (153 / 1920),
              child: propertyImage,
            ),
            Padding(
              padding: EdgeInsets.only(
                // top: width * (10 / 1920),
                // left: width * (10 / 1920),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * (40 / 1920),
                        height: width * (40 / 1920),
                        child: Image.asset(
                          'assets/images/House With a Garden.png',
                        ),
                      ),
                      Text(
                        propertyType,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * (35 / 1920)),
                        child: SizedBox(
                          width: width * (40 / 1920),
                          height: width * (40 / 1920),
                          child: Image.asset('assets/images/Price Tag USD.png'),
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (22 / 1920),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: width * (10 / 1920),
                      left: width * (20 / 1920),
                    ),
                    child: SizedBox(
                      width: width * (272 / 1920),
                      height: width * (70 / 1920),
                      child: SizedBox(
                        width: width * (256 / 1902),
                        height: width * (60 / 1920),
                        child: Text(
                          simplePropertyDescription,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'NunitoSans-Medium',
                            fontSize: width * (18 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * (25 / 1920),
                        height: width * (25 / 1920),
                        child: Image.asset('assets/images/Location.png'),
                      ),
                      Text(
                        address,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'NunitoSans-SemiBold',
                          fontSize: width * (13 / 1920),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
