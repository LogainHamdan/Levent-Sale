import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../../config/constants.dart';

class AdRepository {
  static final AdRepository _instance = AdRepository._internal();

  factory AdRepository() => _instance;

  AdRepository._internal();

  final Dio _dio = Dio();

  Future<Response> createAd({
    required String token,
    required Map<String, dynamic> adDTO,
    required List<File> files,
  }) async {
    final formData = FormData.fromMap({
      "adDTO": jsonEncode(adDTO),
      "files":
          files.map((file) => MultipartFile.fromFileSync(file.path)).toList(),
    });

    return await _dio.post(
      createAdUrl,
      data: formData,
      options: Options(
        headers: {
          "Authorization": token,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }
}
