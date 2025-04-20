import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
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

import '../../../repositories/user-profile-repo.dart';

class FriendProfile extends StatelessWidget {
  final int userId;
  final String token;

  static const id = '/friend-profile';

  const FriendProfile({
    super.key,
    required this.userId,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ProfileProvider>(context, listen: false)
          .loadUserProfile(token, userId),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              leading: const SizedBox(),
              title: Consumer<ProfileProvider>(
                builder: (context, provider, _) {
                  final user = provider.user;
                  return TitleRow(
                    title: user != null
                        ? "${user.firstName} ${user.lastName}"
                        : "الملف الشخصي",
                  );
                },
              ),
            ),
            body: Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                final user = provider.user;
                final error = provider.error;

                if (error != null) {
                  return Center(child: Text('خطأ: $error'));
                }

                if (user == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
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
                                name: "${user.firstName} ${user.lastName}",
                                isVerified: false,
                                image: user.profilePicture ?? '',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        FollowContainer(
                          leftChild: Column(
                            children: const [
                              Text('—',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('يتابع'),
                            ],
                          ),
                          rightChild: Column(
                            children: const [
                              Text('—',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('متابع'),
                            ],
                          ),
                        ),
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
                            !user.isFollowing!
                                ? CustomSmallButton(
                                    isOutlined: false,
                                    onPressed: () {
                                      // متابعة
                                    },
                                    icon: SvgPicture.asset(
                                      addCircleGreenIcon,
                                      height: 20.h,
                                    ),
                                    text: 'متابعة',
                                    buttonColor: kprimaryColor,
                                  )
                                : CustomSmallButton(
                                    isOutlined: false,
                                    onPressed: () {
                                      // إلغاء المتابعة
                                    },
                                    icon: const SizedBox(),
                                    text: 'إلغاء المتابعة',
                                    textColor: Colors.black,
                                    buttonColor: grey8,
                                  ),
                          ],
                        ),
                        SizedBox(height: 16.h),
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
                                    Text(user.email ?? '',
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
                        ProductCard(),
                        ProductCard(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
