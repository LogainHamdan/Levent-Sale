import 'package:dio/dio.dart';

import '../../../config/constants.dart';

class SearchRepository {
  static final SearchRepository _instance = SearchRepository._internal();
  factory SearchRepository() => _instance;
  SearchRepository._internal();

  final Dio _dio = Dio();

  Future<Response> searchAds(String query, int? page, int? size) async {
    print("searchAds called with: $query");

    try {
      print('🔍 Query parameters sent: ${{
        'query': query,
        'page': page,
        'size': size,
      }}');
      final response = await _dio.get(
        searchAdsUrl,
        queryParameters: {
          'query': query,
          'page': page ?? 0,
          'size': size ?? 8,
        },
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
