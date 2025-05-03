import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../auth/models/user.dart';

class FriendProfile extends StatefulWidget {
  final User user;

  static const id = '/friend-profile';

  const FriendProfile({
    super.key,
    required this.user,
  });

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  late final int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.user.id ?? 0;
    print('userId in initState: $userId');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    print('user i want to pass ${widget.user.id}');

    return FutureBuilder(
        future: profileProvider.getProfile(userId: widget.user.id ?? 0),
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

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                leading: const SizedBox(),
                title: TitleRow(
                  title: userToShow != null
                      ? "${userToShow.firstName} ${userToShow.lastName}"
                      : "الملف الشخصي",
                ),
              ),
              body: SingleChildScrollView(
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
                                  "${userToShow?.firstName} ${userToShow?.lastName}",
                              isVerified: false,
                              image: userToShow?.profilePicture ?? '',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      FollowContainer(
                        leftChild: Column(
                          children: [
                            Text('${userToShow?.followingCount ?? 0}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('يتابع'),
                          ],
                        ),
                        rightChild: Column(
                          children: [
                            Text('${userToShow?.followersCount ?? 0}',
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
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    addCircleGreenIcon,
                                    height: 20.h,
                                  ),
                                  text: 'متابعة',
                                  buttonColor: kprimaryColor,
                                  textColor: grey8,
                                )
                              : CustomSmallButton(
                                  isOutlined: false,
                                  onPressed: () {},
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
                                  Text(userToShow?.phoneNumber ?? '',
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
                                  Text(userToShow?.email ?? '',
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
                      ...provider.allAds
                          .where((ad) => ad.userId == userToShow.id)
                          .map((ad) => FutureBuilder(
                                future: provider.getAdById(ad.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error loading ad');
                                  } else {
                                    final adToShow = snapshot.data;
                                    if (adToShow == null) return SizedBox();

                                    return Column(
                                      children: [
                                        ProductCard(ad: provider.selectedAd!),
                                        SizedBox(height: 16.h),
                                      ],
                                    );
                                  }
                                },
                              ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
