import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/following.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import 'followers.dart';

class JoinFollow extends StatefulWidget {
  final int userId;
  static const id = '/join-follow';

  const JoinFollow({super.key, required this.userId});

  @override
  State<JoinFollow> createState() => _JoinFollowState();
}

class _JoinFollowState extends State<JoinFollow> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<FollowProvider>(context, listen: false);

    provider.fetchFollowers(userId: widget.userId);
    provider.fetchFollowingUsers(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);

    return FutureBuilder(
        future: profileProvider.getProfile(userId: widget.userId),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Consumer<FollowProvider>(
            builder: (context, provider, child) => DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                    leading: SizedBox(),
                    title: TitleRow(title: user?.firstName ?? ""),
                    bottom: TabBar(
                      dividerHeight: 0,
                      indicator: BoxDecoration(),
                      labelColor: kprimaryColor,
                      unselectedLabelColor: grey5,
                      labelStyle: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                      unselectedLabelStyle: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                      tabs: <Widget>[
                        Tab(text: "متابِع (${provider.followersCount})"),
                        Tab(text: "متابَع (${provider.followingCount})"),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [FollowersScreen(), FollowingScreen()],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
