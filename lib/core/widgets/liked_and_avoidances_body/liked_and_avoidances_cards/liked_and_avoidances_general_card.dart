import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class LikedAndAvoidancesGeneralCard extends StatelessWidget {
  const LikedAndAvoidancesGeneralCard({
    super.key,
    required this.color,
    required this.theNote,
  });
  final Color color;
  final String theNote;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (373 / 1920),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(width * (5 / 1920)),
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: width * (3 / 1920),
            spreadRadius: width * (2 / 1920),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width * (10 / 1920)),
        child: Center(
          child: Text(
            theNote,
            style: TextStyle(
              color: getPrimaryTextColor(themeProvider.isDarkMode),
              fontFamily: 'NunitoSans-Medium',
              fontSize: width * (24 / 1920),
            ),
          ),
        ),
      ),
    );
  }
}
