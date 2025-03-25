import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/custom-small-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/follow-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/name-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/product-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendProfile extends StatelessWidget {
  final bool? isFollowed;
  static const id = '/friend-profile';

  const FriendProfile({
    super.key,
    this.isFollowed = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          leading: SizedBox(),
          title: TitleRow(
            onBackTap: () =>
                Navigator.pushReplacementNamed(context, MenuScreen.id),
            title: 'منة الله',
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
                        borderRadius: BorderRadius.circular(4.r)),
                    height: 120.h,
                    width: double.infinity,
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
                    Text('2,856',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('يتابع')
                  ],
                ),
                rightChild: Column(
                  children: [
                    Text('1,947',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('متابع')
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSmallButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, ConversationScreen.id),
                    isOutlined: true,
                    icon: Image.asset(
                      'assets/imgs_icons/more/assets/icons/محادثة.png',
                      height: 20.h,
                    ),
                    text: 'محادثة',
                    textColor: kprimaryColor,
                  ),
                  SizedBox(width: 12.w),
                  !isFollowed!
                      ? CustomSmallButton(
                          isOutlined: false,
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/imgs_icons/more/assets/icons/متابعة.png',
                            height: 20.h,
                          ),
                          text: 'متابعة',
                          buttonColor: kprimaryColor)
                      : CustomSmallButton(
                          isOutlined: false,
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/imgs_icons/more/assets/icons/متابعة.png',
                            height: 20.h,
                          ),
                          text: 'الغاء المتابعة',
                          textColor: Colors.black,
                          buttonColor: grey8),
                ],
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
