import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../../more/models/profile.dart';

class CityRepository {
  late final Dio dio;
  static final CityRepository _instance = CityRepository._internal();

  CityRepository._internal() {
    dio = Dio();
  }

  factory CityRepository() => _instance;

  Future<List<City>> getCities({required int governorateId}) async {
    try {
      print('$getCitiesUrl/$governorateId');
      final response = await dio.get(
        '$getCitiesUrl/$governorateId',
        options: Options(headers: {'Accept': '*/*'}),
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        print('cities loaded: ${response.data}');
        return data.map((e) => City.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load cities: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<Governorate>> getGovernorates() async {
    try {
      final response = await dio.get(
        getGovernoratesUrl,
        options: Options(headers: {'Accept': '*/*'}),
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data;
        print(data);
        return data.map((e) => Governorate.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load governorates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<Governorate?> getGovernorateById({required String id}) async {
    try {
      final response = await dio.get(
        '$getGovernorateByIdUrl/$id',
        options: Options(headers: {'Accept': 'application/hal+json'}),
      );

      if (response.statusCode == 200) {
        print('gov: ${response.data}');
        return Governorate.fromJson(response.data);
      } else {
        throw Exception('Failed to load governorate: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<City?> getCityById({required String id}) async {
    try {
      final response = await dio.get(
        '$getCityByIdUrl/$id',
        options: Options(headers: {'Accept': 'application/hal+json'}),
      );

      if (response.statusCode == 200) {
        print('city: ${response.data}');

        return City.fromJson(response.data);
      } else {
        throw Exception('Failed to load city: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }
}
