import 'package:untitled1/core/models/room_modules/room.dart';

enum SinkType { a, b }

enum Direction { east, west, north, south }

class Kitchen extends Room {
  Kitchen({
    required super.description,
    required super.photos,
    required super.type,
    required this.sinkType,
    required this.windowDirections,
    required super.roomSqft,
    required super.paintingDescription,
  });
  final SinkType sinkType;
  final Direction windowDirections;
}
