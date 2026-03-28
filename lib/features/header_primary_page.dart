import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/core/widgets/header/page_header.dart';

class HeaderPrimaryPage extends StatelessWidget {
  const HeaderPrimaryPage({super.key, required this.pageWidget});
  final Widget pageWidget;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: PageHeader(width: width),
      body: pageWidget,
    );
  }
}
