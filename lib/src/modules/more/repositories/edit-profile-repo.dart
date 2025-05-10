import 'dart:convert';
import 'dart:io';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:dio/dio.dart';

import '../models/profile.dart';

class EditProfileRepository {
  static final EditProfileRepository _instance =
      EditProfileRepository._internal(Dio());

  factory EditProfileRepository() {
    return _instance;
  }

  EditProfileRepository._internal(this.dio);

  final Dio dio;

  Future<Profile> updateProfile({
    required String token,
    String? firstName,
    String? lastName,
    String? birthday,
    File? profilePicture,
    String? businessLicense,
    required String governorateId,
    required String cityId,
    String? fullAddress,
  }) async {
    try {
      final formData = FormData.fromMap({
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (birthday != null) 'birthday': birthday,
        if (profilePicture != null)
          'profilePicture': await MultipartFile.fromFile(profilePicture.path),
        if (businessLicense != null) 'businessLicense': businessLicense,
        'governorateId': governorateId,
        'cityId': cityId,
        if (fullAddress != null) 'fullAddress': fullAddress,
      });
      print("form data: ${formData.fields.toString()}");

      final response = await dio.put(
        editProfileUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('profile updated successfully: ${response.data}');
        return Profile.fromJson(response.data is Map<String, dynamic>
            ? response.data
            : json.decode(response.data));
      } else {
        throw Exception("Failed to update profile: ${response.statusCode}");
      }
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
