import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';

class DealCard extends StatelessWidget {
  const DealCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width * (939 / 1920),
          height: width * (246 / 1920),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * (136 / 1920),
                    height: width * (52 / 1920),
                    decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: width * (9 / 1920)),
                      child: Container(
                        width: width * (136 / 1920),
                        height: width * (43 / 1920),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * (331 / 1920),
                    height: width * (194 / 1920),
                    decoration: BoxDecoration(
                      color: backGroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: width * (9 / 1920),
                        left: width * (9 / 1920),
                        right: width * (9 / 1920),
                      ),
                      child: Container(
                        width: width * (331 / 1920),
                        height: width * (194 / 1920),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: width * (136 / 1920),
          top: 0,
          width: width * (608 / 1920),
          height: width * (80 / 1920),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: backGroundColor,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    top: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (452 / 1920),
                    height: width * (62 / 1920),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: width * (9 / 1920),
                    right: width * (9 / 1920),
                    bottom: width * (9 / 1920),
                  ),
                  child: Container(
                    width: width * (129 / 1920),
                    height: width * (71 / 1920),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
