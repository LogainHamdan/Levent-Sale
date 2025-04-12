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
    required FormData formData,
  }) {
    return dio.post(
      editProfileUrl,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }
}
