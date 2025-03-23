import 'package:flutter/material.dart';

class FollowProvider extends ChangeNotifier {
  final List<bool> _followingStatus = List.generate(10, (index) => false);

  bool isFollowing(int index) => _followingStatus[index];

  void toggleFollow(int index) {
    _followingStatus[index] = !_followingStatus[index];
    notifyListeners();
  }
}
