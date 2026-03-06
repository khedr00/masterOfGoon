import 'package:untitled1/core/models/photo.dart';

enum RoomType {
  bedRoom,
  masterBedroom,
  ensuiteBathroom,
  bathRoom,
  livingRoom,
  guestBedroom,
  familyRoom,
  kitchen,
  diningRoom,
  foyer,
  powderRoom,
}

class Room {
  Room({
    required this.type,
    required this.description,
    required this.photos,
    required this.roomSqft,
    required this.paintingDescription,
  });

  final RoomType type;
  final String description;
  final List<Photo> photos;
  final double roomSqft;
  final String paintingDescription;
}
