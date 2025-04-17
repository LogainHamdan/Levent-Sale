import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../config/constants.dart';

import 'package:dio/dio.dart';

import '../models/ad.dart';

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
    final formData = FormData();

    formData.fields.add(MapEntry('adDTO', jsonEncode(ad.toJson())));

    for (var image in images) {
      formData.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      ));
    }

    return await dio.post(
      createAdUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
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
