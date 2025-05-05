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
  Future<AdModel?> createAd({
    required AdModel ad,
    required List<File> images,
    required String token,
  }) async {
    try {
      final formData = FormData();

      formData.fields.add(MapEntry('adDTO', jsonEncode(ad.toJson())));

      final imageFiles = await _prepareFiles(images);

      for (var file in imageFiles) {
        formData.files.add(MapEntry('files', file));
      }

      final response = await dio.post(
        createAdUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Accept': '*/*',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return AdModel.fromJson(response.data);
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
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
        filename: 'image_${timestamp}_$i.$extension',
        contentType: _getMediaType(extension),
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

  Future<List<AdModel>> getUserAds({required int userId}) async {
    try {
      final response = await dio.get('$getUserAdsUrl/$userId',
          options: Options(headers: {'Accept': '*/*'}));

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((json) => AdModel.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected response format: expected a list');
        }
      } else {
        throw Exception('Failed to load ads: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<AdModel?> getAdById({required int id}) async {
    try {
      final response = await dio.get("$getAdUrl/$id");
      print("fetching the ad:${response.statusCode}");
      if (response.statusCode == 200) {
        print(response.data);

        return AdModel.fromJson(response.data);
      } else {
        print('Failed to get ad. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<List<AdModel?>> getMyAdsByStatus({
    required String token,
    required String status,
  }) async {
    try {
      final response = await dio.get(
        '$getAdsByStatus/$status/ads',
        options: Options(
          headers: {
            'Authorization': token,
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
