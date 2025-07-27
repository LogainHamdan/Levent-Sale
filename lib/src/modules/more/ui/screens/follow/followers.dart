import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
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
    return Scaffold(
      body: Consumer<FollowProvider>(
        builder: (context, provider, child) => SafeArea(
          child: provider.isFollowersLoading
              ? Center(child: CustomCircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16.h,
                  ),
                  itemCount: provider.followersCount,
                  itemBuilder: (context, index) {
                    final follower = provider.followers[index];
                    return FollowTile(
                      userId: follower.id ?? 0,
                    );
                  },
                ),
        ),
      ),
    );
  }
}
