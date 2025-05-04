import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/models/address.dart';
import '../../../models/profile.dart';
import '../../../repositories/user-profile-repo.dart';
import '../follow/provider.dart';

class ProfileProvider extends ChangeNotifier {
  final FollowRepository followRepository = FollowRepository();

  Profile? profile;
  String? error;

  Future<Profile?> getProfile({required int userId}) async {
    try {
      final profile = await followRepository.getProfile(userId: userId);
      print('Profile loaded successfully: ${profile?.username}');
      error = null;
      return profile;
    } catch (e) {
      profile = null;

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
