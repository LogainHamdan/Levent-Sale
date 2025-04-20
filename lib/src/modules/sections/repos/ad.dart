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
    final Map<String, dynamic> adMap = ad.toJson();

    final formMap = <String, dynamic>{
      for (var entry in adMap.entries) 'adDTO.${entry.key}': entry.value,
      'files': [
        for (var image in images)
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      ],
    };
    final formData = FormData.fromMap(formMap);

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
      print('${response.statusCode}');
      print('${response.data}');

      return response;
    } on DioException catch (e) {
      print('${e.response?.statusCode}');
      print('${e.message}');
      print('${e.response?.data}');
      rethrow;
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
}
