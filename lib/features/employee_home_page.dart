import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/deals/deal_card_info/deal_card_info.dart';
import 'package:untitled1/back_end_test/deals/get_deal_cards_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/all_and_deals_only_button.dart';
import 'package:untitled1/core/widgets/buttons/double_button/new_and_ongoing_deals_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/personal_and_deals_schedule_widget.dart';
import 'package:untitled1/features/deal_page.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  final List<DealCard> _dealList = [];
  final CancelToken _cancelToken = CancelToken();
  void getDealList() async {
    List<DealCardInfo> dealList = await getDealCardsInfo(
      role: 'Sales',
      id: 1,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      for (int i = 0; i < dealList.length; i++) {
        _dealList.add(DealCard(dealCardInfo: dealList[i]));
      }
    });
  }

  List<bool> _cardIsClicked = [];
  late int _dealId;

  void _falsingcardIsClicked() {
    _cardIsClicked = List.filled(_dealList.length, false);
  }

  @override
  void initState() {
    _falsingcardIsClicked();
    getDealList();
    super.initState();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allAndDealsOnlyProvider = Provider.of<AllAndDealsOnlyProvider>(
      context,
    );
    setState(() {
      allAndDealsOnlyProvider.allAreClicked
          ? _falsingcardIsClicked()
          : DoNothingAction();
    });
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
                NewAndOngoingDealsButton(),
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
                SizedBox(width: width * (660 / 1920)),
                AllAndDealsOnlyButton(),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * (28 / 1920)),
                child: SizedBox(
                  height: width * (794 / 1920),
                  width: width * ((939 + 38) / 1920),
                  child: _dealList.isEmpty
                      ? Container(
                          color: backGroundColor,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ListView.builder(
                          itemCount: _dealList.length,
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
                                        allAndDealsOnlyProvider
                                            .falsingAllAreClicked();
                                        _falsingcardIsClicked();
                                        _cardIsClicked[i] = true;
                                        _dealId = _dealList[i].dealCardInfo.id;
                                      });
                                    },
                                    onDoubleTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DealPage(),
                                        ),
                                      );
                                    },
                                    child: _dealList[i],
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

              allAndDealsOnlyProvider.allAreClicked
                  ? PersonalAndDealsScheduleWidget(employeeId: 1)
                  : DealsOnlyScheduleWidget(
                      key: ValueKey(_dealId),
                      dealId: _dealId,
                      forDealPage: false,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
