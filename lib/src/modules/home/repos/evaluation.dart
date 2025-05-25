import 'package:dio/dio.dart';

import '../../../config/constants.dart';
import '../models/rating.dart';

class EvaluationRepository {
  static final EvaluationRepository _instance =
      EvaluationRepository._internal();

  factory EvaluationRepository() => _instance;

  EvaluationRepository._internal();

  final Dio _dio = Dio();

  Future<List<Rating>?> getMyRatings({required String token}) async {
    try {
      final response = await _dio.get(
        getMyRatingsUrl,
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );
      final data = response.data;
      return (data as List<dynamic>)
          .map((json) => Rating.fromJson(json))
          .toList();
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'ratings fetch failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> addRating(RatingRequest rating,
      {required String token}) async {
    try {
      print('data sent: ${rating.toJson()}');
      final response = await _dio.post(
        addRatingsUrl,
        data: rating.toJson(),
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'ratings add failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<Rating>?> getAdRatings(
      {required String token, required int adId}) async {
    try {
      final response = await _dio.get(
        '$getAdRatingsUrl/$adId',
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      final List<dynamic> data = response.data;
      print(data);
      return data.map((item) => Rating.fromJson(item)).toList();
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'fetching ad rates failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<double?> getAdAvg({required String token, required int adId}) async {
    try {
      final response = await _dio.get(
        '$getAdAvgUrl/$adId',
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
          },
        ),
      );

      final data = response.data;
      return data;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.response?.data}');
      throw Exception(
          'fetching ad avg failed: ${e.response?.statusCode} ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
