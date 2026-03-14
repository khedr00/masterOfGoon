import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/general_tabable_card/genaral_tabable_card.dart';
import 'package:untitled1/core/widgets/general_tabable_card/tab_of_tabable_card.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Column(
        children: [
          // PageHeader(),
          // DealCard(),
          GenaralTabableCard(
            tabs: [
              TabOfTabableCard(
                tabName: 'test',
                tabColors: ThemeColor(
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.pink,
                ),
                bodyOfTheTab: Container(color: Colors.red),
              ),
              TabOfTabableCard(
                tabName: 'test1',
                tabColors: ThemeColor(
                  primaryColor: Colors.purple,
                  secondaryColor: Colors.pink,
                ),
                bodyOfTheTab: Container(color: Colors.green),
              ),
              TabOfTabableCard(
                tabName: 'test2',
                tabColors: ThemeColor(
                  primaryColor: Colors.brown,
                  secondaryColor: Colors.pink,
                ),
                bodyOfTheTab: Container(color: Colors.yellow),
              ),
              TabOfTabableCard(
                tabName: 'test3',
                tabColors: ThemeColor(
                  primaryColor: Colors.yellow,
                  secondaryColor: Colors.pink,
                ),
                bodyOfTheTab: Container(color: Colors.yellow),
              ),
            ],
            fullCardWidth: width * (1000 / 1920),
          ),
        ],
      ),
    );
  }
}
