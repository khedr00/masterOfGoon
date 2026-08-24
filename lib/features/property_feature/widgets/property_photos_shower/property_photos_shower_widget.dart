import 'package:flutter/material.dart';
import 'package:untitled1/features/property_feature/widgets/property_photos_shower/not_primary_property_photos_shower_widget.dart';
import 'package:untitled1/features/property_feature/widgets/property_photos_shower/primary_property_photos_shower_widget.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/property_feature/providers/property_data_provider.dart';
import 'package:untitled1/features/property_feature/data/property_image_source.dart';

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
    final propertyData = context.watch<PropertyDataProvider>();
    final property = propertyData.property;
    final fallback = switch (propertyData.imageContext) {
      PropertyImageContext.room => PropertyImageSource.roomFallback,
      PropertyImageContext.outdoor => PropertyImageSource.outdoorFallback,
      PropertyImageContext.painting => PropertyImageSource.propertyFallback,
      PropertyImageContext.property => PropertyImageSource.propertyFallback,
    };
    final photos = switch (propertyData.imageContext) {
      PropertyImageContext.room =>
        propertyData.selectedRoom?.photos ?? const <String>[],
      PropertyImageContext.outdoor =>
        propertyData.selectedOutdoorItem?.photos ?? const <String>[],
      PropertyImageContext.painting => [
        if (property?.primaryPhoto.isNotEmpty ?? false) property!.primaryPhoto,
        ...?property?.galleryPhoto,
      ],
      PropertyImageContext.property => [
        if (property?.primaryPhoto.isNotEmpty ?? false) property!.primaryPhoto,
        ...?property?.galleryPhoto,
      ],
    };
    return SizedBox(
      width: width * (652 / 1920),
      height: width * (927 / 1920),
      child: isPrimaryPropertyPhotos
          ? PrimaryPropertyPhotosShowerWidget(
              photos: PropertyImageSource.normalizeAll(photos, fallback),
              fallback: fallback,
            )
          : NotPrimaryPropertyPhotosShowerWidget(),
    );
  }
}
