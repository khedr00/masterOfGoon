import 'package:flutter/material.dart';
import 'package:untitled1/back_end_test/deal_requests/deal_request_card_info.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealRequestCard extends StatelessWidget {
  const DealRequestCard({super.key, required this.dealRequestCardInfo});
  final DealRequestCardInfo dealRequestCardInfo;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Container(
      width: 670,
      height: 360,
      color: backGroundColor,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 650,
              height: 340,
              decoration: BoxDecoration(
                color: Color(0xFF94BAF0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 189,
                        height: 340,
                        decoration: BoxDecoration(
                          color: Color(0xFF94BAF0),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 10,
                        height: 340,
                        decoration: BoxDecoration(color: Color(0xFFD0D0D0)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 450,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFFB26B6B),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        width: 450,
                        height: 260,
                        decoration: BoxDecoration(
                          color: backGroundColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.43, -1),
            child: Container(
              width: 170,
              height: 90,
              decoration: BoxDecoration(
                color: Color(0xFFD0D0D0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.415, -1),
            child: Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF1E6A8C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
