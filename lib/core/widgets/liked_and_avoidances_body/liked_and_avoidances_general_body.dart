import 'package:flutter/material.dart';

class LikedAndAvoidancesGeneralBody extends StatelessWidget {
  const LikedAndAvoidancesGeneralBody({super.key, required this.notesList});
  final List<dynamic> notesList;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * (403 / 1920),
      height: width * (500 / 1920),
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
            padding: EdgeInsetsGeometry.all(width * (25 / 1920)),

            child: notesList[i],
          );
        },
      ),
    );
  }
}
