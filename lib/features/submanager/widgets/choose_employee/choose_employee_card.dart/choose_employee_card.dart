import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/back_end_test/get_all_employees/employee_card_info.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/property_feature/data/property_image_source.dart';
import 'package:untitled1/providers/theme_provider.dart';

class ChooseEmployeeCard extends StatelessWidget {
  const ChooseEmployeeCard({
    super.key,
    required this.employee,
    required this.suitability,
    required this.isSelected,
  });

  final EmployeeCardInfo employee;
  final int suitability;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * (720 / 1920),
      height: width * (108 / 1920),
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? darkSecondaryColor : secondaryColor,
        border: Border.all(
          color: isSelected
              ? (themeProvider.isDarkMode ? darkPrimaryColor : primaryColor)
              : Colors.transparent,
          width: width * (3 / 1920),
        ),
        borderRadius: BorderRadius.circular(width * (8 / 1920)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * (18 / 1920)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(width * (8 / 1920)),
              child: PropertyImageSource.image(
                PropertyImageSource.normalize(
                  employee.employeePhoto,
                  'assets/images/profilePhoto-icon.png',
                ),
                'assets/images/profilePhoto-icon.png',
                width: width * (70 / 1920),
                height: width * (70 / 1920),
              ),
            ),
            SizedBox(width: width * (18 / 1920)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    employee.employeeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Bold',
                      fontSize: width * (20 / 1920),
                      color: getPrimaryTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                  SizedBox(height: width * (8 / 1920)),
                  Text(
                    employee.employeeEmail.isEmpty
                        ? 'No email'
                        : employee.employeeEmail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'NunitoSans-Regular',
                      fontSize: width * (16 / 1920),
                      color: getHintTextColor(themeProvider.isDarkMode),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width * (118 / 1920),
              height: width * (52 / 1920),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode
                    ? darkPrimaryColor
                    : primaryColor,
                borderRadius: BorderRadius.circular(width * (6 / 1920)),
              ),
              child: Center(
                child: Text(
                  '$suitability%',
                  style: TextStyle(
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                    color: getTextColor(themeProvider.isDarkMode),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
