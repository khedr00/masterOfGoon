import 'package:untitled1/core/modules/room_modules/room.dart';

class Bedroom extends Room {
  Bedroom({
    required super.description,
    required super.photos,
    required super.type,
    required this.numberOfBeds,
    required this.numberOfClosets,
    required super.roomSqft,
    required super.paintingDescription,
  });
  final int numberOfBeds;
  final int numberOfClosets;
}
