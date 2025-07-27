import 'package:flutter/material.dart';

import '../../../models/car.dart';

class CarSectionProvider with ChangeNotifier {
  Car? _selectedCar;

  Car? get selectedCar => _selectedCar;

  void selectVehicle(Car vehicle) {
    _selectedCar = vehicle;
    notifyListeners();
  }

  bool isSelected(Car vehicle) => _selectedCar == vehicle;
}
