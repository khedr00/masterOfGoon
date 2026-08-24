import 'package:flutter/material.dart';
import 'package:untitled1/features/property_feature/data/property_image_source.dart';

class PrimaryPropertyPhotosShowerWidget extends StatefulWidget {
  const PrimaryPropertyPhotosShowerWidget({super.key, required this.photos, required this.fallback});
  final List<String> photos;
  final String fallback;

  @override
  State<PrimaryPropertyPhotosShowerWidget> createState() =>
      _PrimaryPropertyPhotosShowerWidgetState();
}

class _PrimaryPropertyPhotosShowerWidgetState
    extends State<PrimaryPropertyPhotosShowerWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> photoSizedBoxes = [];
    final photos = List<String>.from(widget.photos);
    if (photos.length % 2 != 0) photos.add('');
    for (int i = 0; i < photos.length; i = i + 2) {
      photoSizedBoxes.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: width * (25 / 1920)),
              child: SizedBox(
                width: width * (266 / 1920),
                height: width * (196 / 1920),
                child: PropertyImageSource.image(photos[i], widget.fallback),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: width * (25 / 1920)),
              child: SizedBox(
                width: width * (266 / 1920),
                height: width * (196 / 1920),
                child: photos[i + 1] != ''
                    ? PropertyImageSource.image(photos[i + 1], widget.fallback)
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
          width: width * (625 / 1920),
          height: width * (441 / 1920),
          child: PropertyImageSource.image(photos.first, widget.fallback),
        ),
        SizedBox(
          width: width * (593 / 1920),
          height: width * (417 / 1920),
          child: SingleChildScrollView(
            child: Column(children: photoSizedBoxes),
          ),
        ),
      ],
    );
  }
}
