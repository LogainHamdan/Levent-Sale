import 'package:Levant_Sale/src/modules/sections/repos/ad.dart';
import 'package:flutter/material.dart';

class AdDetailsProvider extends ChangeNotifier {
  final AdRepository _repo = AdRepository();

  int _currentIndex = 0;
  bool isLoading = false;
  String errorMessage = '';

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> deleteAd({required String token, required int id}) async {
    isLoading = true;
    try {
      final response = await _repo.deleteAd(token: token, id: id);
      if (response.statusCode == 200) {
        print('Ad deleted successfully: ${response.data}');
        notifyListeners();
        errorMessage = '';
      }
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
