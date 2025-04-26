import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'package:dio/dio.dart';
import '../models/ad.dart';
import 'package:http_parser/http_parser.dart';

class AdRepository {
  late final Dio dio;
  static final AdRepository _instance = AdRepository._internal();

  AdRepository._internal() {
    dio = Dio();
  }

  factory AdRepository() => _instance;
  Future<Response> createAd({
    required AdModel ad,
    required List<File> images,
    required String token,
  }) async {
    final String adModelJson = jsonEncode(ad.toJson());

    final formData = FormData.fromMap({
      'adDTO': MultipartFile.fromBytes(
        utf8.encode(adModelJson),
        contentType: MediaType('application', 'json'),
      ),
      // Properly attach files
      'files': await _prepareFiles(images),
    });

    try {
      final response = await dio.post(
        createAdUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print('Error: ${e.response?.statusCode}');
      print('Message: ${e.message}');
      print('Data: ${e.response?.data}');
      rethrow;
    }
  }

// Helper method to prepare files for upload
  Future<List<MultipartFile>> _prepareFiles(List<File> images) async {
    final List<MultipartFile> multipartFiles = [];

    for (final image in images) {
      final multipartFile = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last.replaceAll(' ', '_'),
      );
      multipartFiles.add(multipartFile);
    }

    return multipartFiles;
  }

  Future<Response> updateAd({
    required int adId,
    required AdModel adModel,
    required String token,
  }) async {
    final response = await dio.put(
      '$updateAdUrl/$adId',
      data: adModel.toJson(),
      options: Options(headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      }),
    );

    return response;
  }

  Future<Response> getAds({int page = 0, int size = 8, List<int>? ids}) async {
    try {
      final response = await dio.get(
        adsUrl,
        queryParameters: {
          'page': page,
          'size': size,
          if (ids != null) 'ids': ids,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }
}
