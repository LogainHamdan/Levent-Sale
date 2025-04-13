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
      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        return AdAttributesModel.fromJson(response.data[0]);
      } else {
        debugPrint('${response.data}');
      }
    } catch (e) {
      debugPrint('Repo Error in getAttributesByCategory: $e');
    }
    return null;
  }
}
