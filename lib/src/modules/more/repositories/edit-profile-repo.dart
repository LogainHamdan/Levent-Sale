import 'dart:convert';
import 'dart:io';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

class EditProfileRepository {
  static final EditProfileRepository _instance =
      EditProfileRepository._internal(Dio());

  factory EditProfileRepository() {
    return _instance;
  }

  EditProfileRepository._internal(this.dio);

  final Dio dio;

  Future<Response> updateProfile({
    required String token,
    required Map<String, dynamic> jsonBody,
  }) async {
    try {
      final formData = FormData();

      jsonBody.forEach((key, value) {
        if (value != null) {
          if (key == 'profilePicture' && value is String) {
            formData.fields.add(MapEntry(key, value));
          } else if (value is Map) {
            formData.fields.add(MapEntry(key, jsonEncode(value)));
          } else {
            formData.fields.add(MapEntry(key, value.toString()));
          }
        }
      });

      final response = await dio.put(
        editProfileUrl,
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        }),
      );

      return response;
    } catch (e, stack) {
      print("Repo error: $e");
      if (e is DioException) {
        print("Dio error details: ${e.response?.data}");
      }
      print("Stack trace: $stack");
      rethrow;
    }
  }
}
