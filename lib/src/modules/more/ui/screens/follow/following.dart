import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/widgets/follow-tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingScreen extends StatelessWidget {
  static const id = '/followings';

  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FollowProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: provider.isFollowersLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: provider.followingCount,
                itemBuilder: (context, index) {
                  final followedUser = provider.followingUsers[index];
                  return FollowTile(
                    user: followedUser,
                  );
                },
              ),
      ),
    );
  }
}
