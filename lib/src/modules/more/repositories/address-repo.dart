import 'package:dio/dio.dart';

import '../../../config/constants.dart';

class AddressRepository {
  AddressRepository._();

  static final AddressRepository _instance = AddressRepository._();

  static AddressRepository get instance => _instance;

  final Dio _dio = Dio();

  Future<Response> updateAddress({
    required int addressId,
    required int id,
    required String governorate,
    required String city,
    required String fullAddress,
    required String token,
  }) async {
    final url = "$updateAddressUrl/$addressId";

    try {
      final response = await _dio.put(
        url,
        data: {
          "id": id,
          "governorate": governorate,
          "city": city,
          "fullAddress": fullAddress,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      } else {
        rethrow;
      }
    }
  }
}
