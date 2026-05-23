import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deal_requests/deal_request_card_info.dart';
import 'package:untitled1/back_end_test/deal_requests/get_deal_request_card_info.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/deal_requests_and_signed_deal_requists_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/property_card/property_card.dart';
import 'package:untitled1/core/widgets/property_photos_shower/property_photos_shower_widget.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_widget.dart';
import 'package:untitled1/features/submanager/widgets/deal_request_card/deal_request_card.dart';

class SubmanagerHomePage extends StatefulWidget {
  const SubmanagerHomePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<SubmanagerHomePage> createState() => _SubmanagerHomePageState();
}

class _SubmanagerHomePageState extends State<SubmanagerHomePage> {
  final List<DealRequestCard> _dealRequestList = [];
  final CancelToken _cancelToken = CancelToken();
  void getDealList() async {
    List<DealRequestCardInfo> dealRequestList = await getDealRequestCardsInfo(
      role: widget.userAuthInfo.role,
      id: widget.userAuthInfo.id,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      for (int i = 0; i < dealRequestList.length; i++) {
        _dealRequestList.add(
          DealRequestCard(
            dealRequestCardInfo: dealRequestList[i],
            isReassign: false,
          ),
        );
      }
      _falsingcardIsClicked();
      _cardIsClicked[1] = true;
    });
  }

  List<bool> _cardIsClicked = [];
  void _falsingcardIsClicked() {
    _cardIsClicked = List.filled(_dealRequestList.length, false);
  }

  @override
  void initState() {
    super.initState();
    getDealList();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: width * (30 / 1920),
                  bottom: width * (36 / 1920),
                ),
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(width: width * (42 / 1920)),
                      DealRequestsAndSignedDealRequistsButton(),
                      SizedBox(width: width * (28 / 1920)),
                      ButtonWithImage(
                        image: 'assets/images/Slider.png',
                        widthOfButton: width * (60 / 1920),
                        heightOfButton: width * (40 / 1920),
                        heightOfImage: width * (30 / 1920),
                        widthOfImage: width * (30 / 1920),
                      ),
                      SizedBox(width: width * (28 / 1920)),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * (28 / 1920)),
                        child: Container(
                          height: width * (820 / 1920),
                          width: width * ((670 + 41) / 1920),
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                              horizontal: BorderSide(color: primaryColor),
                            ),
                          ),
                          child: _dealRequestList.isEmpty
                              ? Container(
                                  color: backGroundColor,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(
                                    context,
                                  ).copyWith(scrollbars: false),
                                  child: ListView.builder(
                                    itemCount: _dealRequestList.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: width * (8 / 1920),
                                          bottom: width * (20 / 1920),
                                        ),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _falsingcardIsClicked();
                                                  _cardIsClicked[i] = true;
                                                });
                                              },
                                              child: _dealRequestList[i],
                                            ),
                                            SizedBox(
                                              width: width * (38 / 1920),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: width * (7 / 1920),
                                                  right: width * (16 / 1920),
                                                ),
                                                child: Container(
                                                  width: width * (15 / 1920),
                                                  height: width * (200 / 1920),
                                                  decoration: BoxDecoration(
                                                    color: _cardIsClicked[i]
                                                        ? primaryColor
                                                        : backGroundColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                width *
                                                                    (50 / 1920),
                                                              ),
                                                          bottomRight:
                                                              Radius.circular(
                                                                width *
                                                                    (50 / 1920),
                                                              ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: width * (1150 / 1920),
            height: width * (950 / 1920),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: primaryColor,
                width: width * (4 / 1920),
              ),
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: width * (15 / 1920),
                    ),
                    child: Container(
                      width: width * (200 / 1920),
                      height: width * (40 / 1920),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Lead Info :',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (20 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * (1120 / 1920),
                    height: width * (200 / 1920),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(width * (5 / 1920)),
                      boxShadow: [
                        BoxShadow(
                          color: secondaryColor,
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: width * (189 / 1920),
                                  height: width * (200 / 1920),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                        width * (10 / 1920),
                                      ),
                                      bottomLeft: Radius.circular(
                                        width * (10 / 1920),
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: width * (80 / 1920),
                                        child: SizedBox(
                                          width: width * (100 / 1920),
                                          height: width * (100 / 1920),
                                          child: Image.asset(
                                            'assets/images/profilePhoto-icon.png',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * (189 / 1920),
                                        height: width * ((200 - 80) / 1920),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                fontFamily:
                                                    'NunitoSans-Regular',
                                                fontSize: width * (18 / 1920),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(width * (5 / 1920)),
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
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * (10 / 1920)),
                          child: Container(
                            width: width * (1 / 1920),
                            height: width * (200 / 1920),
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Convertion Probability : 79%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                            Text(
                              'Expected revenue : 1100\$',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                            Text(
                              'Budget : 17000\$',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * (10 / 1920)),
                          child: Container(
                            width: width * (1 / 1920),
                            height: width * (200 / 1920),
                            color: Colors.grey,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Lead Segmentation :',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (22 / 1920),
                              ),
                            ),
                            Text(
                              'Hot',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'NunitoSans-Bold',
                                fontSize: width * (32 / 1920),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: width * (15 / 1920),
                    ),
                    child: Container(
                      width: width * (200 / 1920),
                      height: width * (40 / 1920),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Property Info :',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (20 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * (10 / 1920),
                      top: width * (5 / 1920),
                    ),
                    child: SizedBox(
                      height: width * (890 / 1920),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          PropertyCard(),
                          PropertyPhotosShowerWidget(
                            isPrimaryPropertyPhotos: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: width * (15 / 1920),
                    ),
                    child: Container(
                      width: width * (200 / 1920),
                      height: width * (40 / 1920),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(width * (5 / 1920)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor,
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Choose Employee :',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans-Bold',
                            fontSize: width * (20 / 1920),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ChooseEmployeeWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
