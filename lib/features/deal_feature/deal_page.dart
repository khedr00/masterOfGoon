import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/client_chat/client_chat_widget.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/deal_feature/widgets/deal_actions_widget.dart';
import 'package:untitled1/core/widgets/general_tabable_card/general_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/avoidances_only_body.dart';
import 'package:untitled1/core/widgets/liked_and_avoidances_body/liked_only_body.dart';
import 'package:untitled1/core/widgets/personal_and_deals_schedule_widget/personal_and_deals_schedule_widget.dart/deals_only_schedule_widget/deals_only_schedule_widget.dart';
import 'package:untitled1/features/deal_feature/datasources/get_deal_by_id.dart';
import 'package:untitled1/features/deal_feature/models/deal_model.dart';
import 'package:untitled1/features/property_feature/widgets/property_card/property_card.dart';
import 'package:untitled1/core/widgets/simple_deal_info_card/simple_deal_info_card.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealPage extends StatefulWidget {
  const DealPage({super.key, required this.userAuthInfo, required this.dealId});
  final UserAuthInfo userAuthInfo;
  final String dealId;
  @override
  State<DealPage> createState() => _DealPageState();
}

class _DealPageState extends State<DealPage> {
  final CancelToken _cancelToken = CancelToken();
  DealModel? _dealModel;
  Future<void> _getDealById() async {
    DealModel dealModel = await getDealById(
      dioClient: DioClient(userAuthInfo: widget.userAuthInfo),
      cancelToken: _cancelToken,
      dealId: widget.dealId,
    );

    if (!mounted) {
      return;
    }
    setState(() {
      _dealModel = dealModel;
    });
  }

  bool get _isClosedDeal {
    final status = _dealModel?.dealStatus?.toUpperCase();
    return status == 'COMPLETED' || status == 'FAILED';
  }

  bool get _isManagerView =>
      widget.userAuthInfo.role == 'SALES_MANAGER' ||
      widget.userAuthInfo.role == 'GENERAL_MANAGER';

  @override
  void initState() {
    _getDealById();

    super.initState();
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
    if (_dealModel == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? darkBackGroundColor
          : backGroundColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.only(top: width * (30 / 1920)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: width * (1000 / 1920),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: width * (30 / 1920)),
                      ButtonWithImage(
                        image: 'assets/images/Return.png',
                        widthOfButton: width * (60 / 1920),
                        heightOfButton: width * (60 / 1920),
                        widthOfImage: width * (50 / 1920),
                        heightOfImage: width * (50 / 1920),
                        buttonAction: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: width * (30 / 1920)),
                      SimpleDealInfoCard(
                        dealStage: _dealModel!.dealStatus!,
                        dealTitle: '',
                        dealId: _dealModel!.id!,
                        dealDate: _dealModel!.createdAt!,
                        priceRange:
                            _dealModel!.dealType == 'BUY' ||
                                _dealModel!.dealType == 'RENT'
                            ? 'price range\n${_dealModel!.actualPrice!}\$ - ${_dealModel!.listedPrice!}\$ '
                            : 'listing range\n${_dealModel!.minListingPrice!}% - ${_dealModel!.maxListingPrice}%',
                        successRate:
                            _dealModel!.dealType != 'BUY' ||
                                _dealModel!.dealType != 'RENT'
                            ? 'price: ${_dealModel!.maxPhasedPrice!}\$ \npropfit: ${_dealModel!.profitMargin}%'
                            : '',
                        rentalPeriod: _dealModel!.rentalPeriod,
                        isBUYRENT:
                            _dealModel!.dealType == 'BUY' ||
                            _dealModel!.dealType == 'RENT',
                      ),
                      SizedBox(height: width * (30 / 1920)),
                      GeneralTabableCard(
                        tabs: [
                          TabOfTabableCard(
                            tabName: 'Preferences',
                            tabColor: fifthColorPrimaryGreen,
                            bodyOfTheTab: LikedOnlyBody(),
                          ),
                          TabOfTabableCard(
                            tabName: 'Avoidances',
                            tabColor: sixthColorPrimaryRed,
                            bodyOfTheTab: AvoidancesOnlyBody(),
                          ),
                        ],
                        fullCardWidth: width * (403 / 1920),
                        fullCardHeight: width * (500 / 1920),
                      ),
                    ],
                  ),
                ),
                ClientChatWidget(),
                GeneralTabableCard(
                  key: ValueKey(_isClosedDeal),
                  tabs: [
                    if (!_isManagerView)
                      TabOfTabableCard(
                        tabName: 'schedule',
                        tabColor: themeProvider.isDarkMode
                            ? darkThirdColorPrimary
                            : thirdColorPrimary,
                        bodyOfTheTab: DealsOnlyScheduleWidget(
                          dealId: widget.dealId,
                          forDealPage: true,
                          userAuthInfo: widget.userAuthInfo,
                        ),
                      ),
                    if (!_isManagerView && !_isClosedDeal)
                      TabOfTabableCard(
                        tabName: 'Actions',
                        tabColor: themeProvider.isDarkMode
                            ? darkPrimaryColor
                            : primaryColor,
                        bodyOfTheTab: DealActionsWidget(
                          dealId: widget.dealId,
                          isForBUYRENT:
                              _dealModel!.dealType == 'BUY' ||
                              _dealModel!.dealType == 'RENT',
                          userAuthInfo: widget.userAuthInfo,
                          onDealUpdated: _getDealById,
                        ),
                      ),
                    TabOfTabableCard(
                      tabName: 'Property',
                      tabColor: thirdColorPrimary,
                      bodyOfTheTab: Container(
                        width: width * (881 / 1920),
                        height: width * (910 / 1920),
                        decoration: BoxDecoration(
                          color: getCardColor(themeProvider.isDarkMode),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * (30 / 1920)),
                            bottomLeft: Radius.circular(width * (30 / 1920)),
                            bottomRight: Radius.circular(width * (30 / 1920)),
                          ),
                        ),
                        child: Center(
                          child: PropertyCard(
                            propertyId: _dealModel!.propertyId,
                          ),
                        ),
                      ),
                    ),
                  ],
                  fullCardWidth: width * (895 / 1920),
                  fullCardHeight: width * (910 / 1920),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
