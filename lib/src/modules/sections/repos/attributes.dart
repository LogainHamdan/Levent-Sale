import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/attriburtes.dart';

class AdAttributesRepository {
  static final AdAttributesRepository _instance =
      AdAttributesRepository._internal();
  late final Dio _dio;

  factory AdAttributesRepository() {
    return _instance;
  }

  AdAttributesRepository._internal() {
    _dio = Dio();
  }

  Future<AdAttributesModel?> getAttributesByCategory(int categoryId) async {
    try {
      final response = await _dio.get('$getAttributesById/$categoryId');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return AdAttributesModel.fromJson(data);
        }
      }
    } catch (e) {
      debugPrint('Repo Error in getAttributesByCategory: $e');
    }

    return null;
  }
}
