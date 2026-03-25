import 'package:flutter/material.dart';

class YearMonthDayCalender extends StatefulWidget {
  const YearMonthDayCalender({super.key});

  @override
  State<YearMonthDayCalender> createState() => _YearMonthDayCalenderState();
}

class _YearMonthDayCalenderState extends State<YearMonthDayCalender> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (328 / 1920),
      height: width * (336 / 1920),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * (10 / 1920)),
      ),
      child: DropdownMenu(
        dropdownMenuEntries: [
          DropdownMenuEntry(value: '2026', label: 'year'),
          DropdownMenuEntry(value: '2025', label: 'year2'),
        ],
      ),
    );
  }
}
