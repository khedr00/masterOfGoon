import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/chat_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

class CustomTextFieldForSendMessage extends StatelessWidget {
  const CustomTextFieldForSendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: themeProvider.isDarkMode ? Colors.white.withValues(alpha: 0.2) : Colors.black.withValues(alpha: 0.2),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextFormField(
              controller: provider.controller,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: width * 0.005,
                  horizontal: width * 0.02,
                ),
                fillColor: themeProvider.isDarkMode ? Color(0xff2A2A2A) : Color(0xffEDF6F9),
                filled: true,
                // prefixIcon: Padding(
                //   padding: EdgeInsets.only(left: width * 0.02, right: width * 0.01),
                // ),
                hintText: 'Write a Message',
                hintStyle: TextStyle(
                  color: getHintTextColor(themeProvider.isDarkMode),
                  // fontFamily: fontFamily,
                  fontSize: width * 0.015,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  borderSide: BorderSide(color: themeProvider.isDarkMode ? Color(0xff3A3A3A) : Color(0xffE5F0F4), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  borderSide: BorderSide(color: themeProvider.isDarkMode ? Color(0xff3A3A3A) : Color(0xffE5F0F4), width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  borderSide: BorderSide(color: themeProvider.isDarkMode ? Color(0xff3A3A3A) : Color(0xffE5F0F4), width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  borderSide: BorderSide(color: themeProvider.isDarkMode ? Color(0xff3A3A3A) : Color(0xffE5F0F4), width: 1),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
