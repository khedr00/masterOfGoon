import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class SingleTabTabableCard extends StatefulWidget {
  const SingleTabTabableCard({
    super.key,
    required this.tabName,
    required this.color,
  });
  final String tabName;
  final Color color;

  @override
  State<SingleTabTabableCard> createState() => _SingleTabTabableCardState();
}

class _SingleTabTabableCardState extends State<SingleTabTabableCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: width * (52 / 1920),
          width: width * (301 / 1920),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * (10 / 1920)),
              bottomRight: Radius.circular(width * (30 / 1920)),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: width * (257 / 1920),
                child: Center(
                  child: Text(
                    widget.tabName,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (20 / 1920),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: width * (251 / 1920),
          child: Container(
            width: width * (50 / 1920),
            height: width * (52 / 1920),
            decoration: BoxDecoration(color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor),
          ),
        ),
        Positioned(
          left: width * (251 / 1920),
          child: Container(
            width: width * (10 / 1920),
            height: width * (52 / 1920),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
          ),
        ),
        Positioned(
          top: width * (7 / 1920),
          left: width * (261 / 1920),
          child: Container(
            width: width * (40 / 1920),
            height: width * (45 / 1920),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * (10 / 1920)),
              ),
            ),
          ),
        ),
        Positioned(
          left: width * (261 / 1920),
          child: Container(
            width: width * (40 / 1920),
            height: width * (52 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * (30 / 1920)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
