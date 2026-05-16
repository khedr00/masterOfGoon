import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:untitled1/core/widgets/constants.dart';

class EmployeeMiniCardWidget extends StatelessWidget {
  const EmployeeMiniCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (372 / 1920),
      height: width * (449 / 1920),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * (28 / 1920)),
        border: Border.all(color: primaryColor, width: width * (8 / 1920)),
        boxShadow: [
          BoxShadow(
            blurRadius: width * (10 / 1920),
            color: Colors.black,
            offset: Offset(0, width * (4 / 1920)),
          ),
        ],
      ),

      child: Column(
        children: [
          SizedBox(height: width * (14 / 1920)),

          /// PROFILE IMAGE
          Container(
            width: width * (130 / 1920),
            height: width * (130 / 1920),

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE8EAD9),
            ),

            child: Center(
              child: Image.asset(
                'assets/images/profilePhoto-icon.png',
                width: width * (125 / 1920),
                height: width * (125 / 1920),
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: width * (12 / 1920)),

          /// LOCATION
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * (18 / 1920)),
            child: Text(
              'Al-Qadmous,Tartous,Syria',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NunitoSans-Regular',
                fontSize: width * (20 / 1920),
                color: Colors.black,
              ),
            ),
          ),

          SizedBox(height: width * (16 / 1920)),

          /// CENTER CARDS
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * (16 / 1920)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// PRODUCTIVITY
                Container(
                  width: width * (145 / 1920),
                  height: width * (118 / 1920),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(width * (14 / 1920)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: width * (34 / 1920),
                        lineWidth: width * (9 / 1920),
                        percent: 0.55,
                        animation: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: secondaryColor,
                        backgroundColor: Colors.white,
                        center: Text(
                          '55%',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            color: Colors.white,
                            fontSize: width * (16 / 1920),
                          ),
                        ),
                        footer: Text(
                          'Productivity',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Regular',
                            color: Colors.white,
                            fontSize: width * (15 / 1920),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// CURRENT DEALS
                Container(
                  width: width * (145 / 1920),
                  height: width * (118 / 1920),

                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(width * (14 / 1920)),
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * (10 / 1920),
                      vertical: width * (10 / 1920),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Deals',
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Regular',
                            color: Colors.white,
                            fontSize: width * (16 / 1920),
                          ),
                        ),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/images/Handshake.png',
                                width: width * (42 / 1920),
                                height: width * (42 / 1920),
                              ),

                              Text(
                                '34',
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Bold',
                                  color: Colors.white,
                                  fontSize: width * (42 / 1920),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: width * (16 / 1920)),

          /// DIVIDER
          Container(
            width: double.infinity,
            height: width * (10 / 1920),
            color: backGroundColor,
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * (22 / 1920)),

              child: Row(
                children: [
                  /// MONEY IMAGE
                  Image.asset(
                    'assets/images/Profit.png',
                    width: width * (65 / 1920),
                    height: width * (65 / 1920),
                    fit: BoxFit.contain,
                  ),

                  SizedBox(width: width * (16 / 1920)),

                  /// NAME + ROLE
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Khedr issa',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (28 / 1920),
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          'Sales Employee',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'NunitoSans-Regular',
                            fontSize: width * (24 / 1920),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
