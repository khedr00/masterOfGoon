import 'package:untitled1/core/modules/room_modules/room.dart';

class HallRoom extends Room {
  HallRoom({
    required super.type,
    required super.description,
    required super.photos,
    required super.roomSqft,
    required super.paintingDescription,
    required this.numberOfTables,
    required this.numberOfChairs,
  });
  final int numberOfTables;
  final int numberOfChairs;
}
