import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class DealCardClientSection extends StatelessWidget {
  const DealCardClientSection({
    super.key,
    required this.lastMessage,
    required this.timePassed,
    required this.clientPhoto,
    required this.clientName,
  });

  final String lastMessage;
  final String timePassed;

  final String clientPhoto;
  final String clientName;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (331 / 1920),
      height: width * (194 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkBackGroundColor : backGroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(width * (10 / 1920)),
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
            color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width * (10 / 1920)),
              bottomRight: Radius.circular(width * (10 / 1920)),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: width * (15 / 1920),
                  left: width * (15 / 1920),
                  bottom: width * (8 / 1920),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * (75 / 1920),
                      height: width * (75 / 1920),
                      child: Image.network(clientPhoto),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * (20 / 1920),
                        top: width * (5 / 1920),
                      ),
                      child: Column(
                        children: [
                          Text(
                            clientName,
                            style: TextStyle(
                              color: getPrimaryTextColor(themeProvider.isDarkMode),
                              fontFamily: 'NunitoSans-SemiBold',
                              fontSize: width * (18 / 1920),
                            ),
                          ),
                          // Text(
                          //   '${_clientInfoInsideDealCard!.clientLeadScoring.toString()} %',
                          //   style: TextStyle(
                          //     color: getPrimaryTextColor(themeProvider.isDarkMode),
                          //     fontFamily: 'NunitoSans-SemiBold',
                          //     fontSize: width * (18 / 1920),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * (238 / 1920),
                height: width * (66 / 1920),
                decoration: BoxDecoration(
                  color: getCardColor(themeProvider.isDarkMode),
                  borderRadius: BorderRadius.circular(width * (10 / 1920)),
                ),
                child: Center(
                  child: Text(
                    lastMessage,
                    style: TextStyle(
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                      fontFamily: 'NunitoSans-SemiBold',
                      fontSize: width * (14 / 1920),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: width * (2 / 1920),
                  left: width * (138 / 1920),
                ),
                child: Text(
                  ' $timePassed minutes ago',
                  style: TextStyle(
                    color: getSecondaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-SemiBold',
                    fontSize: width * (12 / 1920),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
