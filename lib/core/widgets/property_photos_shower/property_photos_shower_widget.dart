import 'package:flutter/material.dart';
import 'package:untitled1/core/widgets/property_photos_shower/not_primary_property_photos_shower_widget.dart';
import 'package:untitled1/core/widgets/property_photos_shower/primary_property_photos_shower_widget.dart';

/// هاد الكلاس هو جنب او تحت كرت العقارات البني
/// اللي بكونو ضمن الاكباندد  اوالشرنكد
///  بوبرتي كارد ويذ فوتوز
class PropertyPhotosShowerWidget extends StatelessWidget {
  const PropertyPhotosShowerWidget({
    super.key,
    required this.isPrimaryPropertyPhotos,
  });
  final bool isPrimaryPropertyPhotos;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * (652 / 1920),
      height: width * (927 / 1920),
      child: isPrimaryPropertyPhotos
          ? PrimaryPropertyPhotosShowerWidget()
          : NotPrimaryPropertyPhotosShowerWidget(),
    );
  }
}
