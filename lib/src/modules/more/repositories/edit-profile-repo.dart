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
      final formData = FormData.fromMap(jsonBody);

      final response = await dio.put(editProfileUrl,
          data: formData,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          }));

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
