import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deal_requests/deal_request_card_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealRequestCard extends StatelessWidget {
  const DealRequestCard({
    super.key,
    required this.dealRequestCardInfo,
    required this.isReassign,
  });
  final DealRequestCardInfo dealRequestCardInfo;
  final bool isReassign;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (670 / 1920),
      height: width * (360 / 1920),

      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: width * (650 / 1920),
              height: width * (340 / 1920),
              decoration: BoxDecoration(
                color: Color(0xFF94BAF0),
                borderRadius: BorderRadius.circular(width * (10 / 1920)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (189 / 1920),
                        height: width * (340 / 1920),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(width * (10 / 1920)),
                            bottomLeft: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: width * (80 / 1920),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: width * (10 / 1920),
                                  left: width * (20 / 1920),
                                ),
                                child: SizedBox(
                                  width: width * (100 / 1920),
                                  height: width * (100 / 1920),
                                  child: Image.asset(
                                    'assets/images/profilePhoto-icon.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * (189 / 1920),
                              height: width * ((340 - 80) / 1920),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: width * (10 / 1920),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Khedr Issa',
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Bold',
                                        fontSize: width * (22 / 1920),
                                      ),
                                    ),
                                    Text(
                                      'lead Scoring: 86%',
                                      style: TextStyle(
                                        fontFamily: 'NunitoSans-Regular',
                                        fontSize: width * (18 / 1920),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                        width * (5 / 1920),
                                      ),
                                      width: width * (170 / 1920),
                                      height: width * (140 / 1920),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          width * (10 / 1920),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'I would like to know more about this property',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'NunitoSans-SemiBold',
                                            fontSize: width * (14 / 1920),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (10 / 1920),
                        height: width * (340 / 1920),
                        decoration: BoxDecoration(color: backGroundColor),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: width * (450 / 1920),
                        height: width * (80 / 1920),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                        child: Row(
                          children: [
                            Spacer(flex: 8),
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * (103 / 1920),
                              ),
                              child: Image.asset(
                                'assets/images/House With a Garden.png',
                                width: width * (40 / 1920),
                                height: width * (40 / 1920),
                              ),
                            ),
                            Spacer(flex: 1),
                            Text(
                              'H-233',
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                            Spacer(flex: 8),
                            Image.asset(
                              'assets/images/Price Tag USD.png',
                              width: width * (40 / 1920),
                              height: width * (40 / 1920),
                            ),
                            Spacer(flex: 1),
                            Text(
                              '10000\$',
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                            Spacer(flex: 8),
                          ],
                        ),
                      ),
                      Container(
                        width: width * (450 / 1920),
                        height: width * (260 / 1920),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(width * (10 / 1920)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * (145 / 1920),
                                top: width * (15 / 1920),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Location.png',
                                    width: width * (20 / 1920),
                                    height: width * (20 / 1920),
                                  ),
                                  Text(
                                    'homs-shien',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'NunitoSans-bold',
                                      fontSize: width * (20 / 1920),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * (20 / 1920),
                                vertical: width * (15 / 1920),
                              ),
                              child: Text(
                                'Furnished Apartment with pool and 2 bdcliahfgblcahgcjglaj,gdch.ajdgcasdcalconies Furnished Apartment with pool and 2 balconies',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'NunitoSans-Reguler',
                                  fontSize: width * (18 / 1920),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: backGroundColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(
                                      width * (10 / 1920),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.43, -1),
            child: Container(
              width: width * (170 / 1920),
              height: width * (90 / 1920),
              decoration: BoxDecoration(
                color: Color(0xFFD0D0D0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(width * (10 / 1920)),
                  bottomRight: Radius.circular(width * (10 / 1920)),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.415, -1),
            child: Container(
              width: width * (150 / 1920),
              height: width * (80 / 1920),
              decoration: BoxDecoration(
                color: Color(0xFF1E6A8C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(width * (10 / 1920)),
                  bottomRight: Radius.circular(width * (10 / 1920)),
                ),
              ),
              child: Center(
                child: Text(
                  'purchasing request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (18 / 1920),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
