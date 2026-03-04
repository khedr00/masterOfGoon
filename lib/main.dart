import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/app_bar_component.dart';
import 'package:untitled1/core/widgets/app_bar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: AppBarWidget(
          appBarComponents: [
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/profilePhoto-icon.png',
              appBarCopmonentName: 'Profile',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/Home.png',
              appBarCopmonentName: 'Home',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/notes-icon.png',
              appBarCopmonentName: 'Schedule',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/report-icon.png',
              appBarCopmonentName: 'Reports',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/history-icon.png',
              appBarCopmonentName: 'History',
            ),
            AppBarComponentInfo(
              appBarComponentImage: 'assets/images/Apartment.png',
              appBarCopmonentName: 'Properties',
            ),
          ],
        ),
      ),
    );
  }
}
