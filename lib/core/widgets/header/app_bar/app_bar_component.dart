import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/core/widgets/constants.dart';
import 'package:untitled1/providers/theme_provider.dart';

class AppBarComponent extends StatefulWidget {
  const AppBarComponent({
    super.key,
    required this.component,
    required this.isClicked,
  });
  final AppBarComponentInfo component;
  final bool isClicked;

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return !widget.isClicked
        ? SizedBox(
            width: width * (160 / 1920),
            height: width * (40 / 1920),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * (40 / 1920),
                  height: width * (40 / 1920),
                  decoration: BoxDecoration(
                    color: Color(0x60338EDE),
                    borderRadius: BorderRadius.circular(1000),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff338EDE),
                        spreadRadius: 5,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Image.asset(widget.component.appBarComponentImage),
                ),
                SizedBox(width: width * (12 / 1920)),
                Text(
                  widget.component.appBarCopmonentName,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'NunitoSans-Bold',
                    fontSize: width * (20 / 1920),
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width * (160 / 1920),
                height: width * (40 / 1920),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * (40 / 1920),
                      height: width * (40 / 1920),
                      decoration: BoxDecoration(
                        color: Color(0x60338EDE),
                        borderRadius: BorderRadius.circular(1000),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff338EDE),
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Image.asset(widget.component.appBarComponentImage),
                    ),
                    SizedBox(width: width * (12 / 1920)),
                    Text(
                      widget.component.appBarCopmonentName,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans-Bold',
                        fontSize: width * (20 / 1920),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: width * (140 / 1920),
                height: 1,
                color: getDividerColor(themeProvider.isDarkMode),
              ),
            ],
          );
  }
}

class AppBarComponentInfo {
  const AppBarComponentInfo({
    required this.appBarComponentImage,
    required this.appBarCopmonentName,
    required this.onTap,
  });
  final String appBarCopmonentName;
  final String appBarComponentImage;
  final void Function() onTap;
}
