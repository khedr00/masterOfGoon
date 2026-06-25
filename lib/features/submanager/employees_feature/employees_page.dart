import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/employees_feature/widgets/employee_info_for_sm.dart';
import 'package:untitled1/features/submanager/employees_feature/widgets/employee_mini_card_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final List<EmployeeMiniCardWidget> _employeeMiniCardWidget = List.filled(
    5,
    EmployeeMiniCardWidget(),
  );

  void getDealList() {
    if (!mounted) {
      return;
    }
    setState(() {
      _falsingcardIsClicked();
      _cardIsClicked[1] = true;
    });
  }

  List<bool> _cardIsClicked = [];
  void _falsingcardIsClicked() {
    _cardIsClicked = List.filled(_employeeMiniCardWidget.length, false);
  }

  @override
  void initState() {
    super.initState();
    getDealList();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: width * (30 / 1920),
                  bottom: width * (36 / 1920),
                ),
                child: Row(
                  children: [
                    SizedBox(width: width * (42 / 1920)),

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * (28 / 1920)),
                    child: Container(
                      height: width * (820 / 1920),
                      width: width * ((372 + 41) / 1920),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(color: primaryColor),
                        ),
                      ),
                      child: _employeeMiniCardWidget.isEmpty
                          ? Container(
                              color: backGroundColor,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ScrollConfiguration(
                              behavior: ScrollConfiguration.of(
                                context,
                              ).copyWith(scrollbars: false),
                              child: ListView.builder(
                                itemCount: _employeeMiniCardWidget.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      top: width * (12 / 1920),
                                      bottom: width * (24 / 1920),
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
                                          child: _employeeMiniCardWidget[i],
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
                  ),
                ],
              ),
            ],
          ),
          EmployeeInfoForSm(userAuthInfo: widget.userAuthInfo),
        ],
      ),
    );
  }
}
