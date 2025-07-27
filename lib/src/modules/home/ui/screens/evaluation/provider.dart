import 'dart:io';

import 'package:Levant_Sale/src/modules/home/repos/evaluation.dart';
import 'package:Levant_Sale/src/modules/home/repos/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/rating.dart';

enum LikeType { like, dislike }

class EvaluationProvider extends ChangeNotifier {
  final EvaluationRepository _repo = EvaluationRepository();
  TextEditingController commentController = TextEditingController();
  TextEditingController ratingController = TextEditingController();

  bool isLoading = false;

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

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }

  Future<List<Rating>?> getMyRatings({required String token}) async {
    isLoading = true;

    try {
      final ratings = await _repo.getMyRatings(token: token);
      print('ratings fetched successfully: $ratings');

      return ratings;
    } catch (e) {
      print('Error getting ratings: $e');
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRating(RatingRequest rating, {required String token}) async {
    isLoading = true;

    try {
      final response = await _repo.addRating(rating, token: token);
      if (response.statusCode == 200) {
        print('Rating added successfully: $response');
      }
    } catch (e) {
      print('Error adding rating: $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Rating>?> getAdRatings(
      {required String token, required int adId}) async {
    isLoading = true;

    try {
      final response = await _repo.getAdRatings(token: token, adId: adId);
      print('ad Rating fetched successfully: $response');
      return response;
    } catch (e) {
      print('Error fetching ratings : $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<double?> getAdAvg({required String token, required int adId}) async {
    isLoading = true;

    try {
      final response = await _repo.getAdAvg(token: token, adId: adId);
      print('ad avg: $response');
      return response;
    } catch (e) {
      print('Error fetching avg : $e');
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
