import 'package:Levant_Sale/src/modules/more/ui/screens/follow/repositories/following-repo.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/repositories/follow-repo.dart';
import 'package:flutter/material.dart';

import 'models/followed-model.dart';

class FollowProvider extends ChangeNotifier {
  final FollowingRepository followingRepository;
  final FollowRepository followRepository;
  final String authToken;

  FollowProvider({
    required this.followingRepository,
    required this.followRepository,
    required this.authToken,
  });

  List<FollowedUserModel> _followingUsers = [];
  List<FollowedUserModel> get followingUsers => _followingUsers;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchFollowingUsers(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _followingUsers =
          await followingRepository.getFollowingUsers(userId, authToken);
    } catch (e) {
      print('Error fetching following users: $e');
    } finally {
      _isLoading = false;
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

      user.isFollowing = !user.isFollowing;
      notifyListeners();
    } catch (e) {
      print('Follow toggle error: $e');
    }
  }
}
