import 'package:flutter/material.dart';

class EvaluationProvider extends ChangeNotifier {
  double _rating;

  EvaluationProvider(this._rating);

  double get rating => _rating;

  void updateRating(double newRating) {
    _rating = newRating;
    notifyListeners();
  }
}
