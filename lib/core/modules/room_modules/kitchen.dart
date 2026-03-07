import 'package:untitled1/core/modules/room_modules/room.dart';

enum SinkType { singleBowl, doubleBowl }

enum Direction { east, west, north, south }

class Kitchen extends Room {
  Kitchen({
    required super.description,
    required super.photos,
    required super.type,
    required this.sinkType,
    required this.windowDirection,
    required this.hasCabinets,
    required super.roomSqft,
    required super.paintingDescription,
  });

  final SinkType sinkType;
  final Direction windowDirection;
  final bool hasCabinets;
}
