import 'dart:io';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  final Dio dio;

  ProfileRepository(this.dio);

  Future<Response> updateProfile({
    required String token,
    required FormData formData,
  }) async {
    try {
      final response = await dio.post(
        editProfileUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception("$e");
    }
  }
}
