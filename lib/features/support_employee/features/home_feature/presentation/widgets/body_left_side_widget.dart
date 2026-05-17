import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/widgets/complaint_card.dart';

class BodyLeftSideWidget extends StatefulWidget {
  const BodyLeftSideWidget({super.key});

  @override
  State<BodyLeftSideWidget> createState() => _BodyLeftSideWidgetState();
}

class _BodyLeftSideWidgetState extends State<BodyLeftSideWidget> {
  final List<ComplaintCard> _employeeMiniCardWidget = List.filled(
    5,
    ComplaintCard(
      clientName: 'Ali mostafa',
      clientEmail: 'Khedr@gmail.com',
      clientPhone: '0997676543',
      clientLeadScore: 43,
      complaintTitle: 'Delay in Maintenance Request',
      complaintMessage:
          'Hello,\nI would like to report a delay regarding a maintenance request I submitted last week for a water leakage in my apartment.\nUntil now, I haven’t received any update or visit from the maintenance team.\nI would appreciate it if you could check this issue and let me know when it will be resolved.\nThank you for your support.',
      date: '7/12/2025',
      clientType: 'Client',
    ),
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
    return Column(
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
    );
  }
}
