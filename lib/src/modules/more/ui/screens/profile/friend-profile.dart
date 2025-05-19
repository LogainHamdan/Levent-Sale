import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/more/models/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
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
    final followProvider = Provider.of<FollowProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    print('user i want to pass ${widget.userId}');

    return FutureBuilder(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: const Center(child: CircularProgressIndicator()));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Scaffold(
                body:
                    const Center(child: Text('حدث خطأ أثناء تحميل البيانات')));
          }
          final userToShow = snapshot.data!;
          print('is following:${userToShow.isFollowing}');

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSmallButton(
                            onPressed: () => Navigator.pushNamed(
                                context, ConversationScreen.id),
                            isOutlined: true,
                            icon: SvgPicture.asset(
                              chatGreenIcon,
                              height: 20.h,
                            ),
                            text: 'محادثة',
                            textColor: kprimaryColor,
                          ),
                          SizedBox(width: 12.w),
                          userToShow.isFollowing == false
                              ? CustomSmallButton(
                                  isOutlined: false,
                                  onPressed: () async {
                                    final token = await TokenHelper.getToken();
                                    print(
                                        'to invoke toggle: id: ${widget.userId} and token: $token}');
                                    followProvider.followProfile(context,
                                        followingId: widget.userId,
                                        token: token ?? "");
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
                                    final token = await TokenHelper.getToken();
                                    print('to invoke toggle');
                                    followProvider.unfollowProfile(context,
                                        followingId: widget.userId,
                                        token: token ?? "");
                                  },
                                  icon: const SizedBox(),
                                  text: 'إلغاء المتابعة',
                                  textColor: Colors.black,
                                  buttonColor: grey8,
                                ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        color: grey7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(userToShow.phoneNumber ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 14.w),
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(userToShow.email ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 14.w),
                                  const Icon(Icons.email),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      FutureBuilder<void>(
                        future: _userAdsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('فشل تحميل الاعلانات');
                          } else if (homeProvider.userAds.isEmpty) {
                            return Text('لا يوجد اعلانات لهذا المستخدم');
                          } else {
                            return Column(
                              children: homeProvider.userAds
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
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
