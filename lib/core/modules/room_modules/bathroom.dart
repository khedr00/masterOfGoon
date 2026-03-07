import 'package:untitled1/core/modules/room_modules/room.dart';

enum HeaterType { boiler, solarHeater, electricHeater }

enum ToiletType { arabic, western }

class Bathroom extends Room {
  Bathroom({
    required super.description,
    required super.photos,
    required super.type,
    required this.heaterType,
    required this.hasBathtub,
    required this.toiletType,
    required this.hasMirrorCabinet,
    required super.roomSqft,
    required super.paintingDescription,
  });
  final bool hasBathtub;
  final HeaterType heaterType;
  final ToiletType toiletType;
  final bool hasMirrorCabinet;
}
