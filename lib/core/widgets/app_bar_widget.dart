import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/app_bar_component.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key, required this.appBarComponents});
  final List<AppBarComponentInfo> appBarComponents;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  List<bool> clickedAppBarComponent = [];
  void fillClickedAppBarComponent() {
    for (int i = 0; i < widget.appBarComponents.length; i++) {
      clickedAppBarComponent.add(false);
    }
  }

  @override
  void initState() {
    fillClickedAppBarComponent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double preWidth = MediaQuery.of(context).size.width;
    double width = preWidth * 1920 / 1536;
    return Center(
      child: Container(
        width: width * (((1131 / 6) * widget.appBarComponents.length) / 1920),
        height: width * (70 / 1920),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xff1E6A8C),
          boxShadow: [
            BoxShadow(
              color: Color(0xff257599),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.appBarComponents.length,
            (int i) => GestureDetector(
              onTap: () {
                setState(() {
                  for (int i = 0; i < clickedAppBarComponent.length; i++) {
                    clickedAppBarComponent[i] = false;
                  }
                  clickedAppBarComponent[i] = true;
                });
              },
              child: AppBarComponent(
                component: widget.appBarComponents[i],
                isClicked: clickedAppBarComponent[i],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
