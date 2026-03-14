import 'package:flutter/material.dart';

class OrderOfTabs extends StatefulWidget {
  const OrderOfTabs({super.key, required this.index, required this.child});
  final int index;
  final Widget child;

  @override
  State<OrderOfTabs> createState() => _OrderOfTabsState();
}

class _OrderOfTabsState extends State<OrderOfTabs> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      left: widget.index == 0
          ? 0
          : widget.index == 1
          ? widget.index * (width * (123 / 1920))
          : widget.index * (width * (151 / 1920)) - width * (28 / 1920),
      child: widget.child,
    );
  }
}
