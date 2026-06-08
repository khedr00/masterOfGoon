import 'dart:ui';
import 'package:intl/intl.dart';

// ==================== LIGHT THEME COLORS ====================
Color primaryColor = Color(0xff1E6A8C);
Color secondaryColor = Color(0xff94BAF0);
Color backGroundColor = Color(0xffD0D0D0);
Color thirdColorSecondary = Color(0xff71B2C0);
Color thirdColorPrimary = Color(0xff2A878A);
Color fourthColorPrimaryBrown = Color(0xff534C1D);
Color fourthColorSecondaryLightBrown = Color(0xffAEA778);
Color fifthColorPrimaryGreen = Color(0xff2A8A35);
Color fifthColorSecondaryLightGreen = Color(0xff5BCE68);
Color sixthColorPrimaryRed = Color(0xff8A1719);
Color sixthColorSecondaryLightRed = Color(0xffEB4C4E);

// Additional light theme colors
Color lightCardColor = Color(0xFFFFFFFF);
Color lightBorderColor = Color(0xFFE0E0E0);
Color lightDividerColor = Color(0xFFBDBDBD);
Color lightShadowColor = Color(0x1F000000);
Color lightInputBackgroundColor = Color(0xFFE8E4DB);
Color lightBusinessHealthColor = Color(0xFF8BC2CF);
Color lightBusinessHealthHeaderColor = Color(0xFF2E8F90);
Color lightAlertBackgroundColor = Color(0xFFF04C4E);
Color lightAlertHeaderColor = Color(0xFFAA1116);
Color lightAlertBorderColor = Color(0xFFAA1116);
Color lightNoteColor = Color(0xff545454);
Color lightAppBarShadowColor = Color(0xff257599);
Color lightAppBarIconColor = Color(0xff338EDE);
Color lightAppBarIconBackgroundColor = Color(0x60338EDE);

// ==================== DARK THEME COLORS ====================
// Color darkPrimaryColor = Color(0xff3A9BC4);
// Color darkSecondaryColor = Color(0xff6B8DB8);
// Color darkBackGroundColor = Color(0xff1A1A1A);
// Color darkThirdColorSecondary = Color(0xff4A8C9A);
// Color darkThirdColorPrimary = Color(0xff3A7A7D);
// Color darkFourthColorPrimaryBrown = Color(0xff6B6328);
// Color darkFourthColorSecondaryLightBrown = Color(0xff8B8465);
// Color darkFifthColorPrimaryGreen = Color(0xff3A9A45);
// Color darkFifthColorSecondaryLightGreen = Color(0xff4BDE58);
// Color darkSixthColorPrimaryRed = Color(0xff9A2729);
// Color darkSixthColorSecondaryLightRed = Color(0xffFB5C5E);

// // Dark theme text colors
// Color darkPrimaryTextColor = Color(0xFFFFFFFF);
// Color darkSecondaryTextColor = Color(0xDEFFFFFF);
// Color darkTertiaryTextColor = Color(0x8AFFFFFF);
// Color darkTextColor = Color(0xFF000000);
// Color darkHintTextColor = Color(0x99FFFFFF);

// // Additional dark theme colors
// Color darkCardColor = Color(0xFF2C2C2C);
// Color darkBorderColor = Color(0xFF404040);
// Color darkDividerColor = Color(0xFF606060);
// Color darkShadowColor = Color(0x3F000000);
// Color darkInputBackgroundColor = Color(0xFF3A3A3A);
// Color darkBusinessHealthColor = Color(0xFF4A8C9A);
// Color darkBusinessHealthHeaderColor = Color(0xFF2A6A6D);
// Color darkAlertBackgroundColor = Color(0xFFB03C3E);
// Color darkAlertHeaderColor = Color(0xFF8A0E12);
// Color darkAlertBorderColor = Color(0xFF8A0E12);
// Color darkNoteColor = Color(0xff757575);
// Color darkAppBarShadowColor = Color(0xff4595B9);
// Color darkAppBarIconColor = Color(0xff53AEE8);
// Color darkAppBarIconBackgroundColor = Color(0x6053AEE8);
// ==================== DARK THEME COLORS ====================

// Primary Brand Colors
Color darkPrimaryColor = Color(0xFF60A5FA); // Blue 400
Color darkSecondaryColor = Color(0xFF818CF8); // Indigo 400

// Backgrounds
Color darkBackGroundColor = Color(0xFF0F172A); // Slate 900

// Supporting Colors
Color darkThirdColorPrimary = Color(0xFF06B6D4); // Cyan 500
Color darkThirdColorSecondary = Color(0xFF0891B2); // Cyan 600

// Warning / Accent
Color darkFourthColorPrimaryBrown = Color(0xFFF59E0B); // Amber 500
Color darkFourthColorSecondaryLightBrown = Color(0xFFFBBF24); // Amber 400

// Success
Color darkFifthColorPrimaryGreen = Color(0xFF22C55E); // Green 500
Color darkFifthColorSecondaryLightGreen = Color(0xFF4ADE80); // Green 400

// Error
Color darkSixthColorPrimaryRed = Color(0xFFEF4444); // Red 500
Color darkSixthColorSecondaryLightRed = Color(0xFFF87171); // Red 400

// ==================== TEXT COLORS ====================

Color darkPrimaryTextColor = Color(0xFFFFFFFF);
Color darkSecondaryTextColor = Color(0xCCFFFFFF);
Color darkTertiaryTextColor = Color(0x99FFFFFF);
Color darkTextColor = Color(0xFF000000);
Color darkHintTextColor = Color(0x66FFFFFF);

// ==================== SURFACE COLORS ====================

Color darkCardColor = Color(0xFF1E293B); // Slate 800
Color darkBorderColor = Color(0xFF334155); // Slate 700
Color darkDividerColor = Color(0xFF475569); // Slate 600
Color darkShadowColor = Color(0x80000000);

Color darkInputBackgroundColor = Color(0xFF1E293B);

// ==================== SPECIAL COMPONENTS ====================

Color darkBusinessHealthColor = Color(0xFF06B6D4);
Color darkBusinessHealthHeaderColor = Color(0xFF155E75);

Color darkAlertBackgroundColor = Color(0xFF7F1D1D);
Color darkAlertHeaderColor = Color(0xFF991B1B);
Color darkAlertBorderColor = Color(0xFFB91C1C);

Color darkNoteColor = Color(0xFF94A3B8);

// ==================== APP BAR ====================

Color darkAppBarShadowColor = Color(0x40000000);
Color darkAppBarIconColor = Color(0xFF93C5FD);
Color darkAppBarIconBackgroundColor = Color(0x223B82F6);
///////////////////////////

// ==================== TEXT COLORS ====================
// Light theme text colors
Color lightPrimaryTextColor = Color(0xFF000000);
Color lightSecondaryTextColor = Color(0xDE000000);
Color lightTertiaryTextColor = Color(0x8A000000);
Color lightTextColor = Color(0xFFFFFFFF);
Color lightHintTextColor = Color(0x99000000);

// ==================== SPECIAL COLORS ====================
Color successColor = Color(0xFF4CAF50);
Color warningColor = Color(0xFFFF9800);
Color errorColor = Color(0xFFF44336);
Color infoColor = Color(0xFF2196F3);

// ==================== THEME GETTERS ====================
Color getCardColor(bool isDark) => isDark ? darkCardColor : lightCardColor;
Color getBorderColor(bool isDark) =>
    isDark ? darkBorderColor : lightBorderColor;
Color getDividerColor(bool isDark) =>
    isDark ? darkDividerColor : lightDividerColor;
Color getShadowColor(bool isDark) =>
    isDark ? darkShadowColor : lightShadowColor;
Color getInputBackgroundColor(bool isDark) =>
    isDark ? darkInputBackgroundColor : lightInputBackgroundColor;
Color getBusinessHealthColor(bool isDark) =>
    isDark ? darkBusinessHealthColor : lightBusinessHealthColor;
Color getBusinessHealthHeaderColor(bool isDark) =>
    isDark ? darkBusinessHealthHeaderColor : lightBusinessHealthHeaderColor;
Color getAlertBackgroundColor(bool isDark) =>
    isDark ? darkAlertBackgroundColor : lightAlertBackgroundColor;
Color getAlertHeaderColor(bool isDark) =>
    isDark ? darkAlertHeaderColor : lightAlertHeaderColor;
Color getAlertBorderColor(bool isDark) =>
    isDark ? darkAlertBorderColor : lightAlertBorderColor;
Color getPrimaryTextColor(bool isDark) =>
    isDark ? darkPrimaryTextColor : lightPrimaryTextColor;
Color getSecondaryTextColor(bool isDark) =>
    isDark ? darkSecondaryTextColor : lightSecondaryTextColor;
Color getTertiaryTextColor(bool isDark) =>
    isDark ? darkTertiaryTextColor : lightTertiaryTextColor;
Color getTextColor(bool isDark) => isDark ? darkTextColor : lightTextColor;
Color getHintTextColor(bool isDark) =>
    isDark ? darkHintTextColor : lightHintTextColor;
Color getNoteColor(bool isDark) => isDark ? darkNoteColor : lightNoteColor;
Color getAppBarShadowColor(bool isDark) =>
    isDark ? darkAppBarShadowColor : lightAppBarShadowColor;
Color getAppBarIconColor(bool isDark) =>
    isDark ? darkAppBarIconColor : lightAppBarIconColor;
Color getAppBarIconBackgroundColor(bool isDark) =>
    isDark ? darkAppBarIconBackgroundColor : lightAppBarIconBackgroundColor;

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
