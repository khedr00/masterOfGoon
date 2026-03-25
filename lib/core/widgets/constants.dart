import 'dart:ui';
import 'package:intl/intl.dart';

Color primaryColor = Color(0xff1E6A8C);
Color secondaryColor = Color(0xff94BAF0);
Color backGroundColor = Color(0xffD0D0D0);
Color thirdColorSecondary = Color(0xff71B2C0);
Color thirdColorPrimary = Color(0xff2A878A);

class ThemeColor {
  ThemeColor({required this.primaryColor, required this.secondaryColor});
  final Color primaryColor;
  final Color secondaryColor;
}

String getDayNameFromDateTime(DateTime dateTime) {
  return DateFormat('EEEE').format(dateTime);
}

String getDateFromDateTime(DateTime dateTime) {
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}

String getTimeFromDateTime(DateTime dateTime) {
  return '${dateTime.hour}:${dateTime.minute}';
}
