import 'package:untitled1/core/models/photo.dart';

class OutDoorPlace {
  OutDoorPlace({
    required this.description,
    required this.sqft,
    required this.photos,
  });
  final String description;
  final double sqft;
  final List<Photo> photos;
}
