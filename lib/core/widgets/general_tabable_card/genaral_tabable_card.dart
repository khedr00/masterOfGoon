import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/milti_tab_tabable_card_header.dart';
import 'package:untitled1/core/widgets/general_tabable_card/order_of_tabs.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';

class GenaralTabableCard extends StatefulWidget {
  const GenaralTabableCard({
    super.key,
    required this.tabs,
    required this.fullCardWidth,
    required this.fullCardHeight,
  });
  final List<TabOfTabableCard> tabs;
  final double fullCardWidth;
  final double fullCardHeight;

  @override
  State<GenaralTabableCard> createState() => _GenaralTabableCardState();
}

class _GenaralTabableCardState extends State<GenaralTabableCard> {
  List<Widget> orderOfTabs = [];
  List<bool> isTabed = [];
  int bodyTabed = 0;
  void fillIsTabed() {
    // isTabed = List.filled(widget.tabs.length, false);
    for (int i = 0; i < widget.tabs.length; i++) {
      isTabed.add(false);
    }
    isTabed[0] = true;
  }

  void reset(List<Widget> param) {
    for (int i = 0; i < widget.tabs.length; i++) {
      orderOfTabs.add(
        OrderOfTabs(
          index: i,
          child: GestureDetector(
            onTap: () {
              setState(() {
                for (int i = 0; i < widget.tabs.length; i++) {
                  isTabed[i] = false;
                }
                isTabed[i] = true;
                bodyTabed = i;
                orderOfTabs.clear();
                reset(orderOfTabs);
                Widget tempClickedTab = orderOfTabs.elementAt(i);
                List<Widget> temp = [];
                for (int j = 0; j < i; j++) {
                  temp.add(orderOfTabs[j]);
                }
                orderOfTabs.replaceRange(0, i, temp.reversed);
                orderOfTabs.removeAt(i);
                orderOfTabs.insert(0, tempClickedTab);
              });
            },
            child: MultiTabTabableCardHeader(
              tabName: widget.tabs[i].tabName,
              isTabed: isTabed[i],
              color: widget.tabs[i].tabColors,
              index: i == (widget.tabs.length - 1) ? -1 : i,
              trueTabed: isTabed,
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    fillIsTabed();
    reset(orderOfTabs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: widget.fullCardWidth,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: width * (52 / 1920),
            child: Stack(
              children: List.generate(widget.tabs.length, (int i) {
                return orderOfTabs[i];
              }),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(width * (30 / 1920)),
                  bottomLeft: Radius.circular(width * (30 / 1920)),
                  bottomRight: Radius.circular(width * (30 / 1920)),
                ),
                border: Border.all(
                  color: widget.tabs[bodyTabed].tabColors.primaryColor,
                  width: width * (4 / 1920),
                ),
              ),
              child: SizedBox(
                height: widget.fullCardHeight,
                width: widget.fullCardWidth - (width * (4 / 1920)),
                child: widget.tabs[bodyTabed].bodyOfTheTab,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
