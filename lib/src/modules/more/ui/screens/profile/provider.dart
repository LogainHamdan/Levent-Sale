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
  final FollowRepository followRepository = FollowRepository();

  User? user;
  String? error;

  Future<User?> getProfile({required int userId}) async {
    try {
      final user = await followRepository.getProfile(userId: userId);
      print('user loaded successfully:${user?.username}');
      error = null;
      return user;
    } catch (e) {
      print('user loaded:${user?.username}');
      user = null;

      if (e is DioException) {
        error = "Error: ${e.message}";
      } else {
        error = "An unexpected error occurred: $e";
      }

      print(error);
      notifyListeners();

      return null;
    }
  }
}
