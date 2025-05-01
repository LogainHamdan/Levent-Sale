import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/models/address.dart';
import '../../../repositories/user-profile-repo.dart';
import '../follow/provider.dart';

class ProfileProvider extends ChangeNotifier {
  final UserProfileRepository repository = UserProfileRepository();
  final FollowRepository followRepository = FollowRepository();

  User? user;
  String? error;

  Future<void> loadProfile(String token) async {
    try {
      final response = await repository.getProfile(token);

      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
      } else {
        error = "error ${response.statusCode}";
        user = null;
      }
    } on DioException catch (e) {
      user = null;
      if (e.response != null) {
        error = "${e.response?.statusCode}";
        print(error);
      } else {
        error = "${e.message}";
        print(error);
      }
    } catch (e) {
      user = null;
      error = "$e";
      print(error);
    }
    notifyListeners();
  }

  Future<void> loadUserProfile(String token, int userId) async {
    try {
      final response = await repository.getUserProfile(token, userId);

      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        error = null;
      } else {
        error = " ${response.statusCode}";
        print(error);

        user = null;
      }
    } on DioException catch (e) {
      user = null;
      if (e.response != null) {
        error = "${e.response?.statusCode}";
      } else {
        error = "${e.message}";
        print(error);
      }
    } catch (e) {
      user = null;
      error = " $e";
      print(error);
    }

    notifyListeners();
  }
}
