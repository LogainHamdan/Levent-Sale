import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/simple-title.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/models/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/user-info-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/reports/add-report.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../auth/models/user.dart';
import '../../../../sections/models/ad.dart';
import '../follow/provider.dart';

class FriendProfile extends StatefulWidget {
  final int userId;

  static const id = '/friend-profile';

  const FriendProfile({
    super.key,
    required this.userId,
  });

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  late Future<Profile?> _profileFuture;
  late Future<void> _userAdsFuture;

  @override
  void initState() {
    super.initState();
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    _profileFuture = profileProvider.getProfile(userId: widget.userId);

    _userAdsFuture = homeProvider.loadUserAds(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print('user i want to pass ${widget.userId}');

    return FutureBuilder(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: const Center(child: CustomCircularProgressIndicator()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Scaffold(
                body:
                    const Center(child: Text('حدث خطأ أثناء تحميل البيانات')));
          }
          final userToShow = snapshot.data!;
          print('is following:${userToShow.following}');
          final profileProvider =
              Provider.of<EditProfileProvider>(context, listen: false);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              leading: const SizedBox(),
              title: TitleRow(title: userToShow.username ?? ''),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kprimaryColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            height: 120.h,
                            width: double.infinity,
                          ),
                          Positioned(
                            bottom: -15.h,
                            right: 20.w,
                            child: NameRow(
                              name:
                                  "${userToShow.firstName} ${userToShow.lastName}",
                              isVerified: false,
                              image: userToShow.profilePicture ?? '',
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddReportScreen(adReport: false))),
                              child: Icon(
                                Icons.info_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.h),
                      FollowContainer(
                        userId: widget.userId,
                        leftChild: Column(
                          children: [
                            Text('${userToShow.followingCount}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('يتابع'),
                          ],
                        ),
                        rightChild: Column(
                          children: [
                            Text('${userToShow.followersCount}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('متابع'),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Consumer<FollowProvider>(
                        builder: (context, followProvider, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomSmallButton(
                              onPressed: () async {
                                final currentUser = await UserHelper.getUser();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ConversationScreen(
                                                adId: homeProvider
                                                        .selectedAd?.id ??
                                                    0,
                                                userId: currentUser?.id ?? 0,
                                                receiverId: widget.userId)));
                              },
                              isOutlined: true,
                              icon: SvgPicture.asset(
                                chatGreenIcon,
                                height: 20.h,
                              ),
                              text: 'محادثة',
                              textColor: kprimaryColor,
                            ),
                            SizedBox(width: 12.w),
                            userToShow.following == false
                                ? CustomSmallButton(
                                    isOutlined: false,
                                    onPressed: () async {
                                      final token =
                                          await TokenHelper.getToken();
                                      print(
                                          'to invoke toggle: id: ${widget.userId} and token: $token}');
                                      await followProvider.followProfile(
                                          followingId: widget.userId,
                                          token: token ?? "");
                                      setState(() {
                                        _profileFuture = profileProvider
                                            .getProfile(userId: widget.userId);
                                      });
                                    },
                                    icon: SvgPicture.asset(
                                      addCircleWhiteIcon,
                                      height: 20.h,
                                    ),
                                    text: 'متابعة',
                                    buttonColor: kprimaryColor,
                                    textColor: grey8,
                                  )
                                : CustomSmallButton(
                                    isOutlined: false,
                                    onPressed: () async {
                                      final token =
                                          await TokenHelper.getToken();
                                      print('to invoke toggle');
                                      await followProvider.unfollowProfile(
                                          followingId: widget.userId,
                                          token: token ?? "");
                                      setState(() {
                                        _profileFuture = profileProvider
                                            .getProfile(userId: widget.userId);
                                      });
                                    },
                                    icon: const SizedBox(),
                                    text: 'إلغاء المتابعة',
                                    textColor: Colors.black,
                                    buttonColor: grey8,
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomLabel(
                          text: 'المعلومات',
                          grey: true,
                        ),
                      ),
                      personalInfoContainer(userToShow: userToShow),
                      SizedBox(height: 16.h),
                      Consumer<HomeProvider>(
                        builder: (context, provider, child) =>
                            FutureBuilder<void>(
                          future: _userAdsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CustomCircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('فشل تحميل الاعلانات');
                            } else if (provider.userAds.isEmpty) {
                              return Text('لا يوجد اعلانات لهذا المستخدم');
                            } else {
                              return Column(
                                children: provider.userAds
                                    .map((ad) => Column(
                                          children: [
                                            ProductCard(ad: ad),
                                            SizedBox(height: 16.h),
                                          ],
                                        ))
                                    .toList(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
