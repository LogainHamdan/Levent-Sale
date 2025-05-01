import 'package:Levant_Sale/src/modules/more/repositories/get-follow-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/follow-repo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/ui/screens/login/provider.dart';
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

  Future<void> toggleFollowProfile(BuildContext context,
      {required int followingId, required String token}) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final user =
        await loginProvider.getUserById(id: followingId, token: token ?? '');
    try {
      final response = (user?.isFollowing ?? false)
          ? await followRepository.unfollowUser(
              token: token ?? '', followingId: followingId)
          : await followRepository.followUser(
              token: token ?? '', followingId: followingId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unfollowed successfully!')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to unfollow. Please try again.')));
      }
    } catch (e) {
      debugPrint('$e');
    }
    notifyListeners();
  }

  int get followersCount => _followers.length;

  int get followingCount => _followingUsers.length;
}
