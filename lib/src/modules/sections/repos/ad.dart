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
    final adModelJson = ad.toJson();
    print(
      ad.toJson(),
    );
    final formData = FormData.fromMap({
      'adDTO': jsonEncode(adModelJson),

      // Properly attach files
      'files': await _prepareFiles(images),
    });
    print(formData.fields);
    try {
      final response = await dio.post(
        createAdUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      final actualSize = response.requestOptions.headers['content-length'];
      print("actualSize$actualSize");
      return response;
    } on DioException catch (e) {
      print(e);
      print('Error: ${e.response?.statusCode}');
      print('Message: ${e.message}');
      print('Data: ${e.response?.data}');
      rethrow;
    }
  }

  Future<List<MultipartFile>> _prepareFiles(List<File> images) async {
    final List<MultipartFile> multipartFiles = [];
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      final extension = image.path.split('.').last.toLowerCase();

      multipartFiles.add(await MultipartFile.fromFile(
        image.path,
        filename: 'image_${timestamp}_$i.$extension', // Unique filename
        contentType: _getMediaType(extension), // Proper content type
      ));
    }

    return multipartFiles;
  }

  MediaType _getMediaType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      default:
        return MediaType('application', 'octet-stream');
    }
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

  Future<List<AdModel>> getMyAdsByStatus({
    required String token,
    required String status,
  }) async {
    try {
      final response = await dio.get(
        '$getAdsByStatus/$status/ads',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List data = response.data;
      print(response.data);
      return data.map((e) => AdModel.fromJson(e)).toList();
    } on DioException catch (e) {
      print('Error fetching ads by status: ${e.response?.statusCode}');
      print('Message: ${e.response?.data}');
      rethrow;
    }
  }
}
