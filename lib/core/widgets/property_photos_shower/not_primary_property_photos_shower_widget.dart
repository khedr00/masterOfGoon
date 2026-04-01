import 'package:flutter/material.dart';

class NotPrimaryPropertyPhotosShowerWidget extends StatefulWidget {
  const NotPrimaryPropertyPhotosShowerWidget({super.key});

  @override
  State<NotPrimaryPropertyPhotosShowerWidget> createState() =>
      _NotPrimaryPropertyPhotosShowerWidgetState();
}

class _NotPrimaryPropertyPhotosShowerWidgetState
    extends State<NotPrimaryPropertyPhotosShowerWidget> {
  final List<String> _photos = [
    'assets/images/test_photos/1.jpg',
    'assets/images/test_photos/2.png',
    'assets/images/test_photos/3.jpg',
    'assets/images/test_photos/4.jpg',
    'assets/images/test_photos/5.jpg',
    // 'assets/images/test_photos/5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> photoSizedBoxes = [];
    if (_photos.length % 2 != 0) {
      _photos.add('');
    }
    for (int i = 0; i < _photos.length; i = i + 2) {
      photoSizedBoxes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: width * (25 / 1920)),
              child: SizedBox(
                width: width * (266 / 1920),
                height: width * (196 / 1920),
                child: Image.asset(_photos[i]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: width * (25 / 1920)),
              child: SizedBox(
                width: width * (266 / 1920),
                height: width * (196 / 1920),
                child: _photos[i + 1] != ''
                    ? Image.asset(_photos[i + 1])
                    : SizedBox(),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        SizedBox(
          width: width * (593 / 1920),
          height: width * (881 / 1920),
          child: SingleChildScrollView(
            child: Column(children: photoSizedBoxes),
          ),
        ),
      ],
    );
  }
}
