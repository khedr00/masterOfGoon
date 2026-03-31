import 'package:flutter/material.dart';

class InsidePersonalNotificationWidget extends StatelessWidget {
  const InsidePersonalNotificationWidget({super.key, required this.notesList});
  final List<dynamic> notesList;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (474 / 1920),
      height: width * (800 / 1920),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(width * (30 / 1920)),
          bottomLeft: Radius.circular(width * (30 / 1920)),
          bottomRight: Radius.circular(width * (30 / 1920)),
        ),
      ),
      child: ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: width * (10 / 1920),
              vertical: width * (26 / 1920),
            ),
            child: notesList[i],
          );
        },
      ),
    );
  }
}
