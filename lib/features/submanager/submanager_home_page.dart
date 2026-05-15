import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deal_requests/deal_request_card_info.dart';
import 'package:untitled1/back_end_test/deal_requests/get_deal_request_card_info.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/deal_requests_and_signed_deal_requists_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
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
          DealRequestCard(dealRequestCardInfo: dealRequestList[i]),
        );
      }
      _falsingcardIsClicked();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: width * (30 / 1920),
              bottom: width * (36 / 1920),
            ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * (28 / 1920)),
                    child: SizedBox(
                      height: width * (350 / 1920),
                      width: width * ((939 + 38) / 1920),
                      child: _dealRequestList.isEmpty
                          ? Container(
                              color: backGroundColor,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              itemCount: _dealRequestList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: width * (28 / 1920),
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
                                        // onDoubleTap: () {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => DealPage(),
                                        //     ),
                                        //   );
                                        // },
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
                                                  ? thirdColorPrimary
                                                  : backGroundColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                  width * (50 / 1920),
                                                ),
                                                bottomRight: Radius.circular(
                                                  width * (50 / 1920),
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
                  Text(
                    'Active deals requests',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (36 / 1920),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
