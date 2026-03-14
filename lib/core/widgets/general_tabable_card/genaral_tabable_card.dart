// import 'package:flutter/material.dart';
// import 'package:untitled1/core/widgets/constants.dart';
// import 'package:untitled1/core/widgets/general_tabable_card/milti_tab_tabable_card_header.dart';
// import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';

// class GenaralTabableCard extends StatefulWidget {
//   const GenaralTabableCard({
//     super.key,
//     required this.tabs,
//     required this.fullCardWidth,
//   });
//   final List<TabOfTabableCard> tabs;
//   final double fullCardWidth;

//   @override
//   State<GenaralTabableCard> createState() => _GenaralTabableCardState();
// }

// class _GenaralTabableCardState extends State<GenaralTabableCard> {
//   List<bool> clickedTabsOfTabableCard = [];
//   List<double> orderOfTabs = [];
//   void fillClickedTabsOfTabableCard() {
//     for (int i = 0; i < widget.tabs.length; i++) {
//       clickedTabsOfTabableCard.add(false);
//     }
//     clickedTabsOfTabableCard[0] = true;
//   }

//   @override
//   void initState() {
//     fillClickedTabsOfTabableCard();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     for (int i = 0; i < widget.tabs.length; i++) {
//       orderOfTabs.add(i * (width * (151 / 1920)));
//     }
//     return Container(
//       width: widget.fullCardWidth,
//       decoration: BoxDecoration(
//         color: backGroundColor,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: width * (52 / 1920),
//             child: Stack(
//               children: List.generate(widget.tabs.length, (int i) {
//                 return Positioned(
//                   top: 0,
//                   left: orderOfTabs[i],
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         double tempClickedTab = orderOfTabs.elementAt(i);
//                         orderOfTabs.removeAt(i);
//                         orderOfTabs.insert(0, tempClickedTab);
//                       });
//                     },
//                     child: MultiTabTabableCardHeader(
//                       tabName: widget.tabs[i].tabName,
//                       isTabed: clickedTabsOfTabableCard[i],
//                       color: widget.tabs[i].tabColors,
//                       index: i,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
  });
  final List<TabOfTabableCard> tabs;
  final double fullCardWidth;

  @override
  State<GenaralTabableCard> createState() => _GenaralTabableCardState();
}

class _GenaralTabableCardState extends State<GenaralTabableCard> {
  List<Widget> orderOfTabs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    for (int i = 0; i < widget.tabs.length; i++) {
      orderOfTabs.add(
        OrderOfTabs(
          index: i,
          child: GestureDetector(
            onTap: () {
              setState(() {
                Widget tempClickedTab = orderOfTabs.elementAt(i);
                orderOfTabs.removeAt(i);
                orderOfTabs.insert(0, tempClickedTab);
              });
            },
            child: MultiTabTabableCardHeader(
              tabName: widget.tabs[i].tabName,
              isTabed: false,
              color: widget.tabs[i].tabColors,
              index: i == widget.tabs.length - 1 ? -1 : i,
            ),
          ),
        ),
      );
    }
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
        ],
      ),
    );
  }
}
