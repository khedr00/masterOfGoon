import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/deals/get_deal_cards_info.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/double_button/all_and_deals_only_button.dart';
import 'package:untitled1/core/widgets/buttons/double_button/new_and_ongoing_deals_button.dart';
import 'package:untitled1/core/widgets/buttons/filter_button.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/core/widgets/filter_widgets/deals_filter_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/personal_and_deals_schedule_widget.dart';
import 'package:untitled1/features/deal_page.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';
import 'package:untitled1/providers/employee_deals_filter_provider.dart';
import 'package:untitled1/providers/new_and_ongoing_deals_db_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  final List<DealCard> _dealList = [];
  final CancelToken _cancelToken = CancelToken();
  void getDealList() async {
    List<dynamic> dealList = await getDealCardsInfo(
      role: widget.userAuthInfo.role,
      id: widget.userAuthInfo.id,
      cancelToken: _cancelToken,
      dealStage: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).dealStage,
      propertyType: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).propertyTypes,
      propertyArea: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).cities,
      minPriceRange: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).minPriceRange,
      maxPriceRange: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).maxPriceRange,
      minSR: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).minSuccessRateRange,
      maxSR: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).maxSuccessRateRange,
      minDate: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).minDateRange.toString(),
      maxDate: Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).maxDateRange.toString(),
    );
    if (!mounted) {
      return;
    }
    setState(() {
      if (dealList.isNotEmpty) {
        _dealList.clear();
        for (int i = 0; i < dealList.length; i++) {
          _dealList.add(DealCard(dealCardInfo: dealList[i]));
        }
      }
    });
  }

  List<bool> _cardIsClicked = [];
  String? _dealId;

  void _falsingcardIsClicked() {
    _cardIsClicked = List.filled(_dealList.length, false);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      Provider.of<AllAndDealsOnlyProvider>(
        context,
        listen: false,
      ).truingAllAreClicked();
      Provider.of<NewAndOngoingDealsDbProvider>(
        context,
        listen: false,
      ).truingNewAreClicked();
      Provider.of<EmployeeDealsFilterProvider>(
        context,
        listen: false,
      ).fillFilterInfo(
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      );
    });
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
    // final employeeDealsFilterProvider =
    //     Provider.of<EmployeeDealsFilterProvider>(context);
    // final newAndDealsOnlyProvider = Provider.of<NewAndOngoingDealsDbProvider>(
    //   context,
    // );
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (allAndDealsOnlyProvider.allAreClicked) {
      _falsingcardIsClicked();
    }
    // if (newAndDealsOnlyProvider.newAreClicked) {
    //   print('hhhhhhhh');
    // }
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
                NewAndOngoingDealsButton(),
                SizedBox(width: width * (28 / 1920)),
                FilterButton(
                  buttonAction: () async {
                    final result = await showDialog(
                      context: context,
                      barrierColor: themeProvider.isDarkMode
                          // ignore: deprecated_member_use
                          ? Colors.white.withOpacity(0.4)
                          // ignore: deprecated_member_use
                          : Colors.black.withOpacity(0.4),
                      builder: (context) {
                        return DealsFilterWidget(
                          dealStage: Provider.of<EmployeeDealsFilterProvider>(
                            context,
                            listen: false,
                          ).dealStage,
                          propertyTypes:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).propertyTypes,
                          propertyAreas:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).cities,
                          minPriceRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).minPriceRange,
                          maxPriceRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).maxPriceRange,
                          minSuccessRateRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).minSuccessRateRange,
                          maxSuccessRateRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).maxSuccessRateRange,
                          minDateRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).minDateRange,
                          maxDateRange:
                              Provider.of<EmployeeDealsFilterProvider>(
                                context,
                                listen: false,
                              ).maxDateRange,
                        );
                      },
                    );

                    if (result == true) {
                      setState(() {
                        _dealList.clear();
                      });
                      getDealList();
                    }
                  },
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
                          color: themeProvider.isDarkMode
                              ? darkBackGroundColor
                              : backGroundColor,
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
                                          builder: (context) => DealPage(
                                            userAuthInfo: widget.userAuthInfo,
                                          ),
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
                                              ? (themeProvider.isDarkMode
                                                    ? darkThirdColorPrimary
                                                    : thirdColorPrimary)
                                              : (themeProvider.isDarkMode
                                                    ? darkBackGroundColor
                                                    : backGroundColor),
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
                  ? PersonalAndDealsScheduleWidget(
                      userAuthInfo: widget.userAuthInfo,
                    )
                  : _dealId == null
                  ? SizedBox()
                  : DealsOnlyScheduleWidget(
                      key: ValueKey(_dealId!),
                      dealId: '4af006b7-e48c-429d-9220-15d8c263e42e',
                      //  _dealId!,
                      forDealPage: false,
                      userAuthInfo: widget.userAuthInfo,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
