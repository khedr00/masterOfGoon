import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({
    super.key,

    required this.notecolor,

    required this.dangerIndicatorColor,
    required this.title,
    required this.subTitle,
    required this.date,
    required this.description,
  });

  final Color notecolor;

  final Color dangerIndicatorColor;
  final String title;
  final String subTitle;
  final String date;
  final String description;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          width: width * (443 / 1920),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: width * (24 / 1920),
                width: width * (443 / 1920),
                color: getCardColor(themeProvider.isDarkMode),
              ),
              Container(
                width: width * (443 / 1920),
                decoration: BoxDecoration(
                  color: widget.notecolor,
                  borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      color: widget.notecolor,
                      spreadRadius: width * (2 / 1920),
                      blurRadius: width * (3 / 1920),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: width * (10 / 1920),
                        //     left: width * (10 / 1920),
                        //     right: width * (283 / 1920),
                        //   ),
                        //   child: Container(
                        //     width: width * (15 / 1920),
                        //     height: width * (15 / 1920),
                        //     decoration: BoxDecoration(
                        //       color: widget.dangerIndicatorColor,
                        //       borderRadius: BorderRadius.circular(1000),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: widget.dangerIndicatorColor,
                        //           spreadRadius: width * (2 / 1920),
                        //           blurRadius: width * (3 / 1920),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: width * (340 / 1920)),
                          child: Text(
                            widget.date,
                            style: TextStyle(
                              color: getPrimaryTextColor(
                                themeProvider.isDarkMode,
                              ),
                              fontFamily: 'NunitoSans-MediumItalic',
                              fontSize: width * (14 / 1920),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: width * (10 / 1920),
                        left: width * (20 / 1920),
                        right: width * (20 / 1920),
                        top: width * (40 / 1920),
                      ),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          color: getPrimaryTextColor(themeProvider.isDarkMode),
                          fontFamily: 'NunitoSans-Medium',
                          fontSize: width * (16 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: width * (18 / 1920),
          child: Container(
            width: width * (294 / 1920),
            height: width * (64 / 1920),
            decoration: BoxDecoration(
              color: getCardColor(themeProvider.isDarkMode),
              borderRadius: BorderRadius.circular(width * (5 / 1920)),
            ),
            child: Center(
              child: Container(
                width: width * (278 / 1920),
                height: width * (52 / 1920),
                decoration: BoxDecoration(
                  color: widget.notecolor,
                  borderRadius: BorderRadius.circular(width * (5 / 1920)),
                  boxShadow: [
                    BoxShadow(
                      color: widget.notecolor,
                      spreadRadius: width * (3 / 1920),
                      blurRadius: width * (2 / 1920),
                    ),
                  ],
                ),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (18 / 1920),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
