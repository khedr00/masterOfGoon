import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class InsideTabPersonalAndDealScheduleWidget extends StatefulWidget {
  const InsideTabPersonalAndDealScheduleWidget({
    super.key,
    required this.personalAndDealsNotes,
    this.fullHeight,
  });
  final List<dynamic> personalAndDealsNotes;
  final double? fullHeight;

  @override
  State<InsideTabPersonalAndDealScheduleWidget> createState() =>
      _InsideTabPersonalAndDealScheduleWidgetState();
}

class _InsideTabPersonalAndDealScheduleWidgetState
    extends State<InsideTabPersonalAndDealScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    List<Widget> personalAndDealsNotes = [];
    if (widget.personalAndDealsNotes.length % 2 != 0) {
      widget.personalAndDealsNotes.add(
        Container(
          width: width * (322 / 1920),
          color: themeProvider.isDarkMode
              ? darkBackGroundColor
              : backGroundColor,
        ),
      );
    }
    for (int i = 0; i < widget.personalAndDealsNotes.length; i = i + 2) {
      personalAndDealsNotes.add(
        Padding(
          padding: EdgeInsets.only(top: width * (20 / 1920)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.personalAndDealsNotes[i],
              widget.personalAndDealsNotes[i + 1],
            ],
          ),
        ),
      );
    }
    personalAndDealsNotes.add(
      Container(
        height: width * (50 / 1920),
        width: width * (1 / 1920),
        color: getCardColor(themeProvider.isDarkMode),
      ),
    );

    return Container(
      width: width * (881 / 1920),
      height: widget.fullHeight ?? width * (760 / 1920),
      decoration: BoxDecoration(
        color: getCardColor(themeProvider.isDarkMode),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (30 / 1902)),
          bottomRight: Radius.circular(width * (30 / 1920)),
          topRight: Radius.circular(width * (30 / 1920)),
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: width * (79 / 1920),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: personalAndDealsNotes,
          ),
        ),
      ),
    );
  }
}
