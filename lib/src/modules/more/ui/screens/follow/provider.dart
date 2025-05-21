import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';

import '../../../../auth/models/user.dart';
import '../../../models/follow.dart';
import '../../../models/profile.dart';

class FollowProvider extends ChangeNotifier {
  final FollowRepository followRepository = FollowRepository();
  final String authToken = '';

  List<User> _followers = [];

  List<User> get followers => _followers;
  bool _isFollowersLoading = false;

  bool get isFollowersLoading => _isFollowersLoading;

  List<User> _followingUsers = [];

  List<User> get followingUsers => _followingUsers;
  bool _isFollowingLoading = false;

  bool get isFollowingLoading => _isFollowingLoading;

  Future<void> fetchFollowingUsers({required int userId}) async {
    _isFollowingLoading = true;
    try {
      _followingUsers =
          await followRepository.getFollowingUsers(userId: userId);
    } catch (e) {
      print('Error fetching following: $e');
    } finally {
      _isFollowingLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFollowers({required int userId}) async {
    _isFollowersLoading = true;
    try {
      _followers = await followRepository.getFollowers(userId: userId);
      print('Fetched followers: $_followers');
    } catch (e) {
      _followers = [];
      print('Error fetching followers: $e');
    } finally {
      _isFollowersLoading = false;
      notifyListeners();
    }
  }

  Future<void> followProfile(
      {required int followingId, required String token}) async {
    try {
      final response = await followRepository.followUser(
          token: token, followingId: followingId);
      if (response.statusCode == 200) {
        print('followed successfully');
      } else {
        print('Failed to unfollow. Please try again.');
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  Future<void> unfollowProfile(
      {required int followingId, required String token}) async {
    try {
      final response = await followRepository.unfollowUser(
          token: token, followingId: followingId);
      if (response.statusCode == 200) {
        print('followed successfully');
      } else {
        print('Failed to unfollow. Please try again.');
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  int get followersCount => _followers.length;

  int get followingCount => _followingUsers.length;
}
