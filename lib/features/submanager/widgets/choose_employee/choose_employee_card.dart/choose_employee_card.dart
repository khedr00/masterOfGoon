import 'package:flutter/material.dart';

class ChooseEmployeeCard extends StatelessWidget {
  const ChooseEmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (1100 / 1920),
      height: width * (200 / 1290),
      color: Colors.red,
      child: Row(),
    );
  }
}
