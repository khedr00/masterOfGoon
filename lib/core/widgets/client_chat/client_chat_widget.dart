import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ClientChatWidget extends StatelessWidget {
  const ClientChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (509 / 1920),
      // height: width * (954 / 1920),
      decoration: BoxDecoration(
        border: Border.all(width: width * (4 / 1920), color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor),
        borderRadius: BorderRadius.circular(width * (50 / 1920)),
      ),
      child: Column(
        children: [
          Container(
            width: width * (509 / 1920),
            height: width * (95 / 1920),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width * (50 / 1920)),
                topRight: Radius.circular(width * (50 / 1920)),
              ),
              color: themeProvider.isDarkMode ? darkPrimaryColor : primaryColor,
            ),
          ),
          Container(
            width: width * (509 / 1920),
            height: width * (770 / 1920),
            color: getCardColor(themeProvider.isDarkMode),
          ),
          Container(
            width: width * (509 / 1920),
            height: width * (75 / 1920),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * (50 / 1920)),
                bottomRight: Radius.circular(width * (50 / 1920)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
