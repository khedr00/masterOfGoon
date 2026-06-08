import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/features/login_page.dart';
import 'package:untitled1/features/support_employee/core/services/socket_service.dart';
import 'package:untitled1/features/support_employee/features/home_feature/presentation/chat_provider.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';
import 'package:untitled1/providers/generalmanager_page_selector_provider.dart';
import 'package:untitled1/providers/icon_selector_provider.dart';
import 'package:untitled1/providers/main_employess_page_selector_provider.dart';
import 'package:untitled1/providers/new_and_ongoing_deals_db_provider.dart';
import 'package:untitled1/providers/submanager_page_selector_provider.dart';
import 'package:untitled1/providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AllAndDealsOnlyProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return NewAndOngoingDealsDbProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return MainEmployessPageSelectorProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SubmanagerPageSelectorProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return GeneralmanagerPageSelectorProvider();
          },
        ),

        ChangeNotifierProvider(
          create: (context) {
            return IconSelectorProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ChatProvider(SocketService());
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: backGroundColor,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: darkBackGroundColor,
          ),
          themeMode: themeProvider.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: Scaffold(
            backgroundColor: themeProvider.isDarkMode
                ? darkBackGroundColor
                : backGroundColor,
            body: LoginPage(),
          ),
        );
      },
    );
  }
}
