import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/employee_home_page.dart';
import 'package:untitled1/providers/all_and_deals_only_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AllAndDealsOnlyProvider();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: EmployeeHomePage()),
    );
  }
}
