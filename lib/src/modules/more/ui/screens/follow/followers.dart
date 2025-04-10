import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/widgets/follow-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FollowersScreen extends StatelessWidget {
  static const id = '/followers';

  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FollowProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: provider.isFollowersLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provider.followersCount,
                itemBuilder: (context, index) {
                  final follower = provider.followers[index];
                  final followedUser = provider.followingUsers[index];
                  return FollowTile(
                    follower: follower,
                    index: index,
                    followedUser: followedUser,
                  );
                },
              ),
      ),
    );
  }
}
