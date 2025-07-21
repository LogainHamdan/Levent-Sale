import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/edit-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/add-cover-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/user-info-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../auth/models/user.dart';
import '../../../../home/ui/screens/home/provider.dart';
import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../../sections/ui/screens/section-details/widgets/custom-label.dart';
import '../../../models/profile.dart';
import '../edit-profile/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Profile?> _profileFuture;
  late Future<void> _userAdsFuture;
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = UserHelper.getUser();
    _userFuture.then((user) {
      if (user != null) {
        final profileProvider =
            Provider.of<EditProfileProvider>(context, listen: false);
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        _profileFuture = profileProvider.getProfile(userId: user.id ?? 0);
        _userAdsFuture = homeProvider.loadUserAds(userId: user.id ?? 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder<User?>(
        future: _userFuture,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (!userSnapshot.hasData || userSnapshot.data == null) {
            return const Scaffold(
              body: Center(child: Text('حدث خطأ أثناء تحميل البيانات')),
            );
          }

          final user = userSnapshot.data!;
          print('Current user: ${user.username}');

          return FutureBuilder<Profile?>(
              future: _profileFuture,
              builder: (context, profileSnapshot) {
                if (profileSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!profileSnapshot.hasData || profileSnapshot.data == null) {
                  return const Scaffold(
                    body:
                        Center(child: Text('حدث خطأ أثناء تحميل الملف الشخصي')),
                  );
                }

                final userToShow = profileSnapshot.data!;

                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                    title: TitleRow(title: userToShow.username ?? ''),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
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
                                  child: const AddCoverColumn(),
                                ),
                                Positioned(
                                  bottom: -15.h,
                                  right: 20.w,
                                  child: NameRow(
                                    name:
                                        '${userToShow.firstName ?? ''} ${userToShow.lastName ?? ''}',
                                    isVerified: true,
                                    image: userToShow.profilePicture ?? '',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            FollowContainer(
                              userId: user.id ?? 0,
                              leftChild: Column(
                                children: const [
                                  Text('0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('يتابع'),
                                ],
                              ),
                              rightChild: Column(
                                children: const [
                                  Text('0',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('متابع'),
                                ],
                              ),
                            ),
                            SizedBox(height: 16.h),
                            CustomElevatedButton(
                              text: 'تعديل الملف الشخصي',
                              onPressed: () => Navigator.pushNamed(
                                  context, EditProfileScreen.id),
                              backgroundColor: kprimaryColor,
                              textColor: grey8,
                              icon:
                                  SvgPicture.asset(editWhiteIcon, height: 24.h),
                            ),
                            SizedBox(height: 12.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomLabel(
                                text: 'المعلومات',

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
                                    return Text(
                                        'لا يوجد اعلانات لهذا المستخدم');
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
        });
  }
}
