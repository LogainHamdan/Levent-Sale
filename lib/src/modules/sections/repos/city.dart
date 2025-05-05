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
  Future<List<City>> getCities(
      {int page = 0, int size = 20, List<String>? sort}) async {
    try {
      final response = await dio.get(
        'http://37.148.208.169:8081/cities?page=0&size=20',
        options: Options(headers: {'Accept': 'application/hal+json'}),
        queryParameters: {
          'page': page,
          'size': size,
          if (sort != null) 'sort': sort,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['_embedded']['cities'];
        print(data);
        return data.map((e) => City.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load cities: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<Governorate>> getGovernorates({
    int page = 0,
    int size = 20,
    List<String>? sort,
  }) async {
    try {
      final response = await dio.get(
        getGovernoratesUrl,
        options: Options(headers: {'Accept': 'application/hal+json'}),
        queryParameters: {
          'page': page,
          'size': size,
          if (sort != null) 'sort': sort,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['_embedded']['governorates'];
        print(data);
        return data.map((e) => Governorate.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load governorates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }
}
