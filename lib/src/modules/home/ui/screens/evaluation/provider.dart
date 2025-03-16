import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EvaluationProvider extends ChangeNotifier {
  double _rating;
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  EvaluationProvider(this._rating);

  double get rating => _rating;
  void updateRating(double newRating) {
    _rating = newRating;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }
}
