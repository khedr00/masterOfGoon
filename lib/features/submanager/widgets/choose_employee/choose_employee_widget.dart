// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/submanager/widgets/choose_employee/choose_employee_card.dart/choose_employee_card.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ChooseEmployeeWidget extends StatelessWidget {
  const ChooseEmployeeWidget({super.key});

  void _showPriceDialog(BuildContext context, double width) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      barrierColor: themeProvider.isDarkMode
          ? Colors.white.withOpacity(0.4)
          : Colors.black.withOpacity(0.4),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: width * (500 / 1920),
            padding: EdgeInsets.all(width * (25 / 1920)),
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode
                  ? darkSecondaryColor
                  : secondaryColor,
              borderRadius: BorderRadius.circular(width * (15 / 1920)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose the price range',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (24 / 1920),
                  ),
                ),

                SizedBox(height: width * (30 / 1920)),

                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Regular',
                    fontSize: width * (18 / 1920),
                    color: getPrimaryTextColor(themeProvider.isDarkMode),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter price range',
                    hintStyle: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (18 / 1920),
                      color: getHintTextColor(themeProvider.isDarkMode),
                    ),
                    filled: true,
                    fillColor: getCardColor(themeProvider.isDarkMode),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: width * (20 / 1920),
                      vertical: width * (18 / 1920),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * (12 / 1920)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                SizedBox(height: width * (30 / 1920)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.isDarkMode
                            ? darkPrimaryColor
                            : primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * (35 / 1920),
                          vertical: width * (15 / 1920),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width * (10 / 1920),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: getTextColor(themeProvider.isDarkMode),
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (18 / 1920),
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * (35 / 1920),
                          vertical: width * (15 / 1920),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            width * (10 / 1920),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NunitoSans-Bold',
                          fontSize: width * (18 / 1920),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    List<ChooseEmployeeCard> chooseEmployeeCard = List.filled(
      5,
      const ChooseEmployeeCard(),
    );

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * (1140 / 1920),
      height: width * (940 / 1920),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: width * (10 / 1920)),
              child: Text(
                'Recommended Employees',
                style: TextStyle(
                  color: getPrimaryTextColor(themeProvider.isDarkMode),
                  fontFamily: 'NunitoSans-Bold',
                  fontSize: width * (20 / 1920),
                ),
              ),
            ),

            SizedBox(
              width: width * (800 / 1920),
              height: width * (900 / 1920),

              child: ListView.builder(
                itemCount: chooseEmployeeCard.length,

                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () {
                      _showPriceDialog(context, width);
                    },

                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: width * (15 / 1920),
                      ),
                      child: chooseEmployeeCard[i],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
