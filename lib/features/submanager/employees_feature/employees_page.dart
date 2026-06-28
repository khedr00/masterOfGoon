import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/get_all_employees/employee_card_info.dart';
import 'package:untitled1/back_end_test/get_all_employees/get_employee_cards_info.dart';
import 'package:untitled1/back_end_test/login/dio_client.dart';
import 'package:untitled1/back_end_test/login/user_auth_info.dart';
import 'package:untitled1/core/widgets/buttons/button_with_image.dart';
import 'package:untitled1/core/widgets/buttons/button_with_text.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/general_manager_pages.dart/widgets/add_employee_widget.dart';
import 'package:untitled1/features/submanager/employees_feature/widgets/employee_info_for_sm.dart';
import 'package:untitled1/features/submanager/employees_feature/widgets/employee_mini_card_widget.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key, required this.userAuthInfo});
  final UserAuthInfo userAuthInfo;

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  String _employeeId = '';
  List<EmployeeCardInfo> _employeeCardInfoList = [];
  final List<EmployeeMiniCardWidget> _employeeMiniCardWidget = [];
  final CancelToken _cancelToken = CancelToken();
  void _getEmploeeCardsInfo() async {
    DioClient dioClient = DioClient(userAuthInfo: widget.userAuthInfo);
    List<EmployeeCardInfo> employeeCardsInfoList = await getEmployeeCardsInfo(
      dioClient: dioClient,
      cancelToken: _cancelToken,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _employeeCardInfoList = employeeCardsInfoList;
      for (int i = 0; i < employeeCardsInfoList.length; i++) {
        _employeeMiniCardWidget.add(
          EmployeeMiniCardWidget(employeeCardInfo: employeeCardsInfoList[i]),
        );
      }
      _falsingcardIsClicked();
      _cardIsClicked[0] = true;
      _employeeId = _employeeCardInfoList[0].employeeId;
    });
  }

  List<bool> _cardIsClicked = [];
  void _falsingcardIsClicked() {
    _cardIsClicked = List.filled(_employeeMiniCardWidget.length, false);
  }

  @override
  void initState() {
    super.initState();
    _getEmploeeCardsInfo();
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
                    SizedBox(width: width * (28 / 1920)),
                    widget.userAuthInfo.role == 'GENERAL_MANAGER'
                        ? ButtonWithText(
                            widthOfButton: width * (200 / 1920),
                            heightOfButton: width * (40 / 1920),
                            text: 'Add Employee',
                            buttonAction: () {
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AddEmployeeWidget(
                                      userAuthInfo: widget.userAuthInfo,
                                    );
                                  },
                                );
                              });
                            },
                          )
                        : SizedBox(),
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

                                              _employeeId =
                                                  _employeeCardInfoList[i]
                                                      .employeeId;
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
          EmployeeInfoForSm(
            userAuthInfo: widget.userAuthInfo,
            employeeId: _employeeId,
          ),
        ],
      ),
    );
  }
}
