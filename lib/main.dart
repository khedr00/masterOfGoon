import 'package:flutter/material.dart';
import 'package:untitled1/features/employee_home_page.dart';

void main() {
  runApp(const MyApp());
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
