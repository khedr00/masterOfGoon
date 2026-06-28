import 'package:flutter/material.dart';

class IdTransportProvider extends ChangeNotifier {
  String _employeeId = '';

  String? get getEmployeeId => _employeeId;

  void setEmployeeId({required String employeeId}) {
    _employeeId = employeeId;
    notifyListeners();
  }
}
