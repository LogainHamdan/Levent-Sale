import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../models/root-category.dart';

class CategoriesRepository {
  static final CategoriesRepository _instance =
      CategoriesRepository._internal();

  factory CategoriesRepository() => _instance;

  CategoriesRepository._internal();

  final Dio _dio = Dio();

  Future<List<RootCategoryModel>> fetchCategories() async {
    try {
      final response = await _dio.get(getCategoriesUrl);
log("url$getCategoriesUrl");
      List data = response.data;

      return data.map((json) => RootCategoryModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<Response> getCategoryById(int id) async {
    try {
      return await _dio.get('$getCategoryByIdUrl/$id');
    } catch (e) {
      if (e is DioException) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response> getSubcategories(int id) async {
    try {
      return await _dio.get('$getSubcategoryUrl/$id');
    } catch (e) {
      if (e is DioException) {
        return e.response ??
            Response(
              requestOptions: RequestOptions(path: getSubcategoryUrl),
              statusCode: 500,
              statusMessage: 'No response from server',
            );
      }
      rethrow;
    }
  }

  Future<Response> getCategoryChildren(int id) async {
    try {
      return await _dio.get('$getCategoryChildrenUrl/$id');
    } catch (e) {
      if (e is DioException) {
        return e.response!;
      }
      rethrow;
    }
  }
}
