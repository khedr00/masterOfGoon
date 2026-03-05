import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/deal_card/deal_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: DealCard()),
    );
  }
}
