import 'package:flutter/material.dart';

class TabablePropertyIcon extends StatelessWidget {
  const TabablePropertyIcon({
    super.key,
    required this.image,
    required this.text,
  });
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width * (60 / 1920),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: width * (10 / 1920)),
            child: SizedBox(
              width: width * (60 / 1920),
              height: width * (60 / 1920),
              child: Image.asset(image),
            ),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'NunitoSans-Regular',
              fontSize: width * (32 / 1920),
            ),
          ),
        ],
      ),
    );
  }
}
