import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/icon_selector_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class TabablePropertyIcon extends StatelessWidget {
  const TabablePropertyIcon({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    final allAndDealsOnlyProvider = Provider.of<IconSelectorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        allAndDealsOnlyProvider.selectIcon(image);
        allAndDealsOnlyProvider.selectText(text);
      },
      child: SizedBox(
        height: width * (60 / 1920),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: width * (10 / 1920)),
              child: SizedBox(
                width: width * (60 / 1920),
                height: width * (60 / 1920),
                child: Image.asset(image),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: getPrimaryTextColor(themeProvider.isDarkMode),
                fontFamily: 'NunitoSans-Regular',
                fontSize: width * (32 / 1920),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
