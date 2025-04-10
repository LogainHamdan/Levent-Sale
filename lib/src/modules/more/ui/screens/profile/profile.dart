import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/edit-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/add-cover-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../follow/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          title: 'منة الله',
        ),
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
                        borderRadius: BorderRadius.circular(4.r)),
                    height: 120.h,
                    width: double.infinity,
                    child: AddCoverColumn(),
                  ),
                  Positioned(
                    bottom: -15.h,
                    right: 20.w,
                    child: NameRow(
                      name: 'منة الله',
                      isVerified: true,
                      image: 'assets/imgs_icons/home/assets/imgs/منال.png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              FollowContainer(
                leftChild: Column(
                  children: [
                    Text(
                      '${Provider.of<FollowProvider>(context).followingCount}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('يتابع'),
                  ],
                ),
                rightChild: Column(
                  children: [
                    Text(
                      '${Provider.of<FollowProvider>(context).followersCount}', // نفس الرقم لحين وجود بيانات مختلفة
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('متابع'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                text: 'تعديل الملف الشخصي',
                onPressed: () =>
                    Navigator.pushNamed(context, EditProfileScreen.id),
                backgroundColor: kprimaryColor,
                textColor: grey8,
                icon: SvgPicture.asset(
                  editWhiteIcon,
                  height: 24.h,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                color: grey7,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text(
                          '059 7146 852',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: 14.w),
                        Icon(Icons.phone),
                      ]),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text('minnabasim12@gmail.com',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(width: 14.w),
                        Icon(Icons.email),
                      ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ProductCard(),
              ProductCard(),
              ProductCard(),
            ],
          ),
        )),
      ),
    );
  }
}
