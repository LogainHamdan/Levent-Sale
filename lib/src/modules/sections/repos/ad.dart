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
    final formData = FormData.fromMap({
      'adDTO': ad.toJson(),
      'files': images.map((image) {
        return MultipartFile.fromFileSync(image.path,
            filename: image.path.split('/').last);
      }).toList(),
    });

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
