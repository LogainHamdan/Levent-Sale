import 'package:Levant_Sale/src/modules/more/repositories/get-follow-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:flutter/material.dart';

import '../../../models/followers.dart';
import '../../../models/following.dart';

class FollowProvider extends ChangeNotifier {
  final GetFollowRepository getFollowRepository = GetFollowRepository();
  final FollowRepository followRepository = FollowRepository();
  final String authToken = '';

  List<FollowerModel> _followers = [];
  List<FollowerModel> get followers => _followers;
  bool _isFollowersLoading = false;
  bool get isFollowersLoading => _isFollowersLoading;

  List<FollowedUserModel> _followingUsers = [];
  List<FollowedUserModel> get followingUsers => _followingUsers;
  bool _isFollowingLoading = false;
  bool get isFollowingLoading => _isFollowingLoading;

  Future<void> fetchFollowers(int userId) async {
    _isFollowersLoading = true;
    notifyListeners();
    try {
      _followers = await getFollowRepository.getFollowers(userId);
    } catch (e) {
      _followers = [];
      print('Error fetching followers: $e');
    } finally {
      _isFollowersLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchFollowingUsers(int userId) async {
    _isFollowingLoading = true;
    notifyListeners();

    try {
      _followingUsers =
          await getFollowRepository.getFollowingUsers(userId, authToken);
    } catch (e) {
      print('Error fetching following users: $e');
    } finally {
      _isFollowingLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFollow(int index) async {
    final user = _followingUsers[index];

    try {
      if (user.isFollowing) {
        await followRepository.unfollowUser(user.id, authToken);
      } else {
        await followRepository.followUser(user.id, authToken);
      }
      notifyListeners();
    } catch (e) {
      print(' $e');
    }
  }

  int get followersCount => _followers.length;

  int get followingCount => _followingUsers.length;
}
