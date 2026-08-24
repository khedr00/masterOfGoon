import 'package:flutter/foundation.dart';
import 'package:untitled1/features/property_feature/data/models/property_api_model.dart';
import 'package:untitled1/features/property_feature/data/property_api_service.dart';

enum PropertyImageContext { property, room, outdoor, painting }

class PropertyDataProvider extends ChangeNotifier {
  PropertyDataProvider({PropertyApiService? service})
    : _service = service ?? PropertyApiService();
  final PropertyApiService _service;
  final Map<String, PropertyApiModel> _cache = {};
  String? selectedPropertyId;
  String? selectedRoomId;
  String? selectedOutdoorItemId;
  PropertyImageContext imageContext = PropertyImageContext.property;
  bool isLoading = false;
  Object? error;
  int _requestVersion = 0;

  PropertyApiModel? get property =>
      selectedPropertyId == null ? null : _cache[selectedPropertyId];
  RoomItemApiModel? get selectedRoom => property?.roomItems
      .where((item) => item.id == selectedRoomId)
      .cast<RoomItemApiModel?>()
      .firstOrNull;
  OutdoorItemApiModel? get selectedOutdoorItem => property?.outdoorItems
      .where((item) => item.id == selectedOutdoorItemId)
      .cast<OutdoorItemApiModel?>()
      .firstOrNull;

  Future<void> selectProperty(String? propertyId) async {
    if (propertyId == null || propertyId.isEmpty) {
      selectedPropertyId = null;
      _resetDependentState();
      notifyListeners();
      return;
    }
    if (selectedPropertyId == propertyId && property != null) return;
    selectedPropertyId = propertyId;
    _resetDependentState();
    final version = ++_requestVersion;
    if (_cache.containsKey(propertyId)) {
      error = null;
      notifyListeners();
      return;
    }
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final result = await _service.getPropertyById(propertyId);
      if (version == _requestVersion) _cache[propertyId] = result;
    } catch (exception) {
      if (version == _requestVersion) error = exception;
    } finally {
      if (version == _requestVersion) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void selectRoom(String? roomId) {
    selectedRoomId = roomId;
    selectedOutdoorItemId = null;
    imageContext = PropertyImageContext.room;
    notifyListeners();
  }

  void selectOutdoorItem(String? itemId) {
    selectedOutdoorItemId = itemId;
    selectedRoomId = null;
    imageContext = PropertyImageContext.outdoor;
    notifyListeners();
  }

  void selectPaintingContext() {
    selectedRoomId = null;
    selectedOutdoorItemId = null;
    imageContext = PropertyImageContext.painting;
    notifyListeners();
  }

  void selectPropertyContext() {
    _resetDependentState();
    notifyListeners();
  }

  void _resetDependentState() {
    selectedRoomId = null;
    selectedOutdoorItemId = null;
    imageContext = PropertyImageContext.property;
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
