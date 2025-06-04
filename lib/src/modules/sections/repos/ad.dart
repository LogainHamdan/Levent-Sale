import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import '../../../config/constants.dart';
import 'package:dio/dio.dart';
import '../models/ad.dart';
import 'package:http_parser/http_parser.dart';

import '../models/adDTO.dart';
import '../models/filter.dart';

class AdRepository {
  late final Dio dio;
  static final AdRepository _instance = AdRepository._internal();

  AdRepository._internal() {
    dio = Dio();
  }

  factory AdRepository() => _instance;

  Future<Response> createAd({
    required AdDTO adDTO,
    List<File>? files,
    required String token,
  }) async {
    try {
      print(adDTO.toJson());
      final formData = FormData();

      formData.files.add(MapEntry(
        'adDTO',
        MultipartFile.fromBytes(
          utf8.encode(json.encode(adDTO)),
          filename: 'ad.json',
          contentType: MediaType('application', 'json'),
        ),
      ));

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          if (await file.exists()) {
            formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(
                file.path,
                filename: basename(file.path),
              ),
            ));
          } else {
            print('⚠️ الملف غير موجود: ${file.path}');
          }
        }
      } else {
        formData.files.add(MapEntry(
          'files',
          MultipartFile.fromBytes([], filename: ''),
        ));
      }
      print(formData);
      print('to create before request');

      final response = await dio.post(
        createAdUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Response> deleteAd({
    required int id,
    required String token,
  }) async {
    try {
      final response = await dio.delete(
        '$deleteAdUrl/$id',
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );
      print('deleted successfully');

      return response;
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

  Future<Response> updateAd(
    AdDTO adDTO,
    List<File>? files, {
    required int id,
    required String token,
  }) async {
    try {
      print(adDTO.toJson());
      final formData = FormData();

      formData.files.add(MapEntry(
        'adDTO',
        MultipartFile.fromBytes(
          utf8.encode(json.encode(adDTO)),
          filename: 'ad.json',
          contentType: MediaType('application', 'json'),
        ),
      ));

      if (files != null && files.isNotEmpty) {
        for (final file in files) {
          if (await file.exists() && file is File) {
            formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(
                file.path,
                filename: basename(file.path),
              ),
            ));
          } else {
            print('⚠️ الملف غير موجود: ${file.path}');
          }
        }
      } else {
        formData.files.add(MapEntry(
          'files',
          MultipartFile.fromBytes([], filename: ''),
        ));
      }
      print(formData);
      print('to update before request');

      final response = await dio.put(
        '$updateAdUrl/$id',
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
            'Accept': '*/*',
          },
        ),
      );
      print('update response: ${response.statusCode}');

      return response;
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Status: ${e.response?.statusCode}');
      print('Response: ${e.response?.data}');
      rethrow;
    }
  }

  Future<Response> getAds(
      {String? token, int page = 0, int size = 8, List<int>? ids}) async {
    try {
      final response = await dio.get(adsUrl,
          queryParameters: {
            'page': page,
            'size': size,
            if (ids != null) 'ids': ids,
          },
          options: Options(headers: {
            'Authorization': token,
          }));
      return response;
    } catch (e) {
      throw Exception('Repository API error: $e');
    }
  }

  Future<Response> getCategoryAds(
    FilterRequestDTO filter, {
    required String categoryId,
    String? token,
    int? size,
    int? page,
  }) async {
    try {
      final response = await dio.post(
        '$getCategoryAdsUrl/$categoryId',
        data: filter.toJson(),
        queryParameters: {'page': page, 'size': size},
        options: Options(
          headers: {
            if (token != null) 'Authorization': token,
            'Content-Type': 'application/json',
            'Accept': '*/*',
          },
        ),
      );
      print('ads for category $categoryId : ${response.data}');
      print('filter : ${filter.toJson()}\n categoryId : $categoryId\n');
      return response;
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.message}');
        print('Response: ${e.response?.data}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Unknown error: $e');
      }
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
    int? page,
    int? size,
  }) async {
    try {
      final response = await dio.get(
        '$getAdsByStatus',
        queryParameters: {'status': status, 'page': page, 'size': size},
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
      );

      print('$status ads fetched successfully : ${response.data}');

      final content = response.data['content'];

      if (content == null || content is! List) {
        print('No ads found or invalid format');
        return [];
      }

      final ads = content.map<AdModel>((e) => AdModel.fromJson(e)).toList();
      print('$status Ads API Response: $ads');

      return ads;
    } on DioException catch (e) {
      print('Error fetching ads by status: ${e.response?.statusCode}');
      print('Message: ${e.response?.data}');
      rethrow;
    }
  }
}
