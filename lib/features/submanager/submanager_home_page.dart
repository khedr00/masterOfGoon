import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/back_end_test/sales_manager_requests/gat_all_manager_requests.dart';
import 'package:untitled1/back_end_test/sales_manager_requests/sales_manager_request_model.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/deal_requests_and_signed_deal_requists_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/widgets/deal_request_card/deal_request_card.dart';
import 'package:untitled1/features/submanager/widgets/right_side_of_sm_home/right_side_of_sm_home.dart';
import 'package:untitled1/providers/theme_provider.dart';

class SubmanagerHomePage extends StatefulWidget {
  const SubmanagerHomePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<SubmanagerHomePage> createState() => _SubmanagerHomePageState();
}

class _SubmanagerHomePageState extends State<SubmanagerHomePage> {
  DealRequestCardInfo? _selectedDealRequest;
  List<DealRequestCardInfo> dealRequestCardInfo1 = [];
  final List<DealRequestCard> _dealRequestList = [];
  final CancelToken _cancelToken = CancelToken();

  void getDealList() async {
    DioClient dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
    List<DealRequestCardInfo> dealRequestList = await getAllRequests(
      dioClient: dioClient,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      dealRequestCardInfo1 = dealRequestList;
      _dealRequestList.clear();

      if (dealRequestList.isNotEmpty) {
        _selectedDealRequest = dealRequestList[0];
      }

      for (int i = 0; i < dealRequestList.length; i++) {
        _dealRequestList.add(
          DealRequestCard(
            dealRequestCardInfo: dealRequestList[i],
            isReassign: false,
          ),
        );
      }
      _falsingcardIsClicked();
      if (_cardIsClicked.isNotEmpty) {
        _cardIsClicked[0] = true;
      }
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                      IconButton(
                        icon: Icon(
                          themeProvider.isDarkMode
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: themeProvider.isDarkMode
                              ? getPrimaryTextColor(true)
                              : getPrimaryTextColor(false),
                        ),
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                        tooltip: 'Toggle Theme',
                      ),
                      SizedBox(width: width * (28 / 1920)),
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
                              horizontal: BorderSide(
                                color: themeProvider.isDarkMode
                                    ? darkPrimaryColor
                                    : primaryColor,
                              ),
                            ),
                          ),
                          child: _dealRequestList.isEmpty
                              ? Container(
                                  color: themeProvider.isDarkMode
                                      ? darkBackGroundColor
                                      : backGroundColor,
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
                                                  _selectedDealRequest =
                                                      dealRequestCardInfo1[i];
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
                                                        ? (themeProvider
                                                                  .isDarkMode
                                                              ? darkPrimaryColor
                                                              : primaryColor)
                                                        : (themeProvider
                                                                  .isDarkMode
                                                              ? darkBackGroundColor
                                                              : backGroundColor),
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
              color: getCardColor(themeProvider.isDarkMode),
              border: Border.all(
                color: themeProvider.isDarkMode
                    ? darkPrimaryColor
                    : primaryColor,
                width: width * (4 / 1920),
              ),
              borderRadius: BorderRadius.circular(width * (10 / 1920)),
            ),
            child: SingleChildScrollView(
              child: _selectedDealRequest == null
                  ? const Center(child: CircularProgressIndicator())
                  : RightSideOfSmHome(
                      key: ValueKey(_selectedDealRequest!.id),
                      userAuthInfo: widget.userAuthInfo,
                      dealRequest: _selectedDealRequest!,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
