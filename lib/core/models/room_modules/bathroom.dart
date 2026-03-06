import 'package:untitled1/core/models/room_modules/room.dart';

enum HeaterType { kasan, sunPoweredBourds, electricalHeater }

enum ToiletType { arabian, english }

class Bathroom extends Room {
  Bathroom({
    required super.description,
    required super.photos,
    required super.type,
    required this.heaterType,
    required this.isBanio,
    required this.toiletType,
    required super.roomSqft,
    required super.paintingDescription,
  });
  final bool isBanio;
  final HeaterType heaterType;
  final ToiletType toiletType;
}
