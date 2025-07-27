import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/widgets/follow-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';

class FollowingScreen extends StatelessWidget {
  static const id = '/followings';

  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FollowProvider>(
        builder: (context, provider, child) => SafeArea(
          child: provider.isFollowersLoading
              ? Center(child: CustomCircularProgressIndicator())
              : ListView.separated(
                  itemCount: provider.followingCount,
                  itemBuilder: (context, index) {
                    final followedUser = provider.followingUsers[index];
                    return FollowTile(
                      userId: followedUser.id ?? 0,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16.h,
                  ),
                ),
        ),
      ),
    );
  }
}
