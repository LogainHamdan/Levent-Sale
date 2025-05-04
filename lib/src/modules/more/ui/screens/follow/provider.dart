import 'package:Levant_Sale/src/modules/more/repositories/get-follow-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';

import '../../../../auth/models/user.dart';
import '../../../models/follow-count.dart';

class FollowProvider extends ChangeNotifier {
  final FollowRepository followRepository = FollowRepository();
  final String authToken = '';
  FollowCount? _followCount;

  List<User> _followers = [];

  List<User> get followers => _followers;
  bool _isFollowersLoading = false;

  bool get isFollowersLoading => _isFollowersLoading;

  List<User> _followingUsers = [];

  List<User> get followingUsers => _followingUsers;
  bool _isFollowingLoading = false;

  FollowCount? get followCount => _followCount;

  bool get isFollowingLoading => _isFollowingLoading;

  Future<void> fetchFollowCount(int userId) async {
    try {
      _followCount = await followRepository.getFollowCount(userId: userId);
      notifyListeners();
    } catch (e) {
      print("Error fetching follow count: $e");
    }
  }

  Future<void> fetchFollowingUsers({required int userId}) async {
    _isFollowingLoading = true;
    notifyListeners();

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
    notifyListeners();
    try {
      _followers = await followRepository.getFollowers(userId: userId);
    } catch (e) {
      _followers = [];
      print('Error fetching followers: $e');
    } finally {
      _isFollowersLoading = false;
      notifyListeners();
    }
  }

  Future<void> followProfile(BuildContext context,
      {required int followingId, required String token}) async {
    try {
      final response = await followRepository.followUser(
          token: token, followingId: followingId);
      if (response.statusCode == 200) {
        print('followed successfully');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unfollowed successfully!')));
      } else {
        print('Failed to unfollow. Please try again.');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to unfollow. Please try again.'),
          backgroundColor: errorColor,
        ));
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  Future<void> unfollowProfile(BuildContext context,
      {required int followingId, required String token}) async {
    try {
      final response = await followRepository.unfollowUser(
          token: token, followingId: followingId);
      if (response.statusCode == 200) {
        print('followed successfully');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unfollowed successfully!')));
      } else {
        print('Failed to unfollow. Please try again.');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to unfollow. Please try again.'),
          backgroundColor: errorColor,
        ));
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  int get followersCount => _followers.length;

  int get followingCount => _followingUsers.length;
}
