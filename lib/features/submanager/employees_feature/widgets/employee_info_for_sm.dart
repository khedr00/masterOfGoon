import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/deals/get_deal_cards_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';
import 'package:untitled1/features/deal_page.dart';
import 'package:untitled1/features/profile_feature/widgets/profile_card.dart';
import 'package:untitled1/features/profile_feature/widgets/stats_widget.dart/stats_widget.dart';
import 'package:untitled1/providers/theme_provider.dart';

class EmployeeInfoForSm extends StatefulWidget {
  const EmployeeInfoForSm({super.key});

  @override
  State<EmployeeInfoForSm> createState() => _EmployeeInfoForSmState();
}

class _EmployeeInfoForSmState extends State<EmployeeInfoForSm> {
  bool _isDealsChosen = false;
  final List<DealCard> _dealList = [];
  final CancelToken _cancelToken = CancelToken();
  void getDealList() async {
    List<dynamic> dealList = await getDealCardsInfo(
      role: '',
      id: '1',
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

  @override
  void initState() {
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (1438 / 1920),
      height: width * (950 / 1920),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(top: width * (43 / 1920)),
            child: ProfileCard(),
          ),
          Container(
            width: width * (5 / 1920),
            height: width * (920 / 1920),
            color: getDividerColor(themeProvider.isDarkMode),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDealsChosen = false;
                      });
                    },
                    child: Text(
                      'Stats',
                      style: TextStyle(
                        fontFamily: _isDealsChosen
                            ? 'NunitoSans-Bold'
                            : 'NunitoSans-Black',
                        fontSize: width * (28 / 1920),
                        color: getPrimaryTextColor(themeProvider.isDarkMode),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * (30 / 1920)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDealsChosen = true;
                        });
                      },
                      child: Text(
                        'Deals',
                        style: TextStyle(
                          fontFamily: !_isDealsChosen
                              ? 'NunitoSans-Bold'
                              : 'NunitoSans-Black',
                          fontSize: width * (28 / 1920),
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _isDealsChosen
                  ? Padding(
                      padding: EdgeInsets.only(left: width * (28 / 1920)),
                      child: SizedBox(
                        height: width * (794 / 1920),
                        width: width * ((939 + 38) / 1920),
                        child: _dealList.isEmpty
                            ? Container(
                                color: themeProvider.isDarkMode
                                    ? darkBackGroundColor
                                    : backGroundColor,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
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
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) {
                                                  return DealPage();
                                                },
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
                                                color: themeProvider.isDarkMode
                                                    ? darkBackGroundColor
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
                    )
                  : StatsWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
