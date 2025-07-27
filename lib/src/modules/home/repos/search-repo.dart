import 'package:dio/dio.dart';

import '../../../config/constants.dart';

class SearchRepository {
  static final SearchRepository _instance = SearchRepository._internal();
  factory SearchRepository() => _instance;
  SearchRepository._internal();

  final Dio _dio = Dio();

  Future<Response> searchAds(
      {required String query, int? page = 0, int? size = 8}) async {
    print("searchAds called with: $query");

    try {
      print('Query parameters sent: ${{
        'query': query,
        'page': page,
        'size': size,
      }}');
      final response = await _dio.get(
        '$searchAdsUrl$query&page=$page&size=$size',
        options: Options(headers: {'Accept': '*/*'}),

      );

      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'Search Ads failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception(e);
    }
  }
}
