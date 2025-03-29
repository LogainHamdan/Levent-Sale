import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/follow/following.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import 'followers.dart';

class JoinFollow extends StatelessWidget {
  static const id = '/join-follow';

  const JoinFollow({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              leading: SizedBox(),
              title: TitleRow(
                  onBackTap: () =>
                      Navigator.pushNamed(context, ProfileScreen.id),
                  title: 'منة الله'),
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
                  Tab(text: "متابِع (10)"),
                  Tab(text: "متابَع (60)"),
                ],
              ),
            ),
            body: TabBarView(
              children: [FollowingScreen(), FollowersScreen()],
            ),
          ),
        ));
  }
}
