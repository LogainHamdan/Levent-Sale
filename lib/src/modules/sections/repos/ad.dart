import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../config/constants.dart';

import 'package:dio/dio.dart';

import '../models/ad.dart';

class AdRepository {
  static final AdRepository _instance = AdRepository._internal();

  AdRepository._internal();

  factory AdRepository() => _instance;
  Future<void> createAd({
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

    final response = await Dio().post(
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
}
