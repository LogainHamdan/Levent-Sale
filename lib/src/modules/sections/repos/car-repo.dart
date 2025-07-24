import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../../more/models/profile.dart';
import '../models/car.dart';

class CarRepository {
  late final Dio dio;
  static final CarRepository _instance = CarRepository._internal();

  CarRepository._internal() {
    dio = Dio();
  }

  factory CarRepository() => _instance;

  Future<List<dynamic>> getYears() async {
    try {
      final response = await dio.get(
        getYearsUrl,
        options: Options(headers: {'Accept': '*/*'}),
      );
      print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        print('years loaded: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to load years: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<dynamic>> getBrands({required int year}) async {
    try {
      final response = await dio.get(
        getBrandsUrl,
        queryParameters: {'year': year},
        options: Options(headers: {'Accept': '*/*'}),
      );
      print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        print('brands loaded: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<dynamic>> getModels({
    required int year,
    required String brand,
  }) async {
    try {
      final response = await dio.get(
        getModelsUrl,
        queryParameters: {
          'year': year,
          'brand': brand,
        },
        options: Options(headers: {'Accept': '*/*'}),
      );
      print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        print('models loaded: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to load models: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<dynamic>> getTransmissions({
    required int year,
    required String brand,
    required String model,
  }) async {
    try {
      final response = await dio.get(
        getTransmissionsUrl,
        queryParameters: {
          'year': year,
          'brand': brand,
          'model': model,
        },
        options: Options(headers: {'Accept': '*/*'}),
      );
      print(response.data);
      if (response.statusCode == 200 && response.data is List) {
        print('trans loaded: ${response.data}');
        return response.data;
      } else {
        throw Exception('Failed to load trans: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<Car>> getCars({
    required int year,
    required String brand,
    required String model,
    required String transmission,
  }) async {
    try {
      final response = await dio.get(
        getCarsUrl,
        queryParameters: {
          'year': year,
          'brand': brand,
          'model': model,
          'transmission': transmission,
        },
        options: Options(headers: {'Accept': '*/*'}),
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;

        return data
            .whereType<Map<String, dynamic>>()
            .map((json) => Car.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load cars: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }
}
