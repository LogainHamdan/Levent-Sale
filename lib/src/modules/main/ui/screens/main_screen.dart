import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/main/ui/screens/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const id = '/main';

  MainScreen({super.key});

  final List<String> unselectedIcons = [
    menuUnselected,
    collectionUnselected,
    sectionsUnselected,
    homeUnselected
  ];

  final List<String> selectedIcons = [
    menuSelected,
    collectionSelected,
    sectionsSelected,
    homeSelected
  ];
  final List<Widget> screens = const [
    MenuScreen(),
    MyCollectionScreen(empty: false),
    Sections(),
    HomeScreen(),
  ];

  final List<String> labels = const [
    "المزيد",
    "تشكيلتي",
    "الأقسام",
    "الرئيسية",
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: screens[bottomNavProvider.currentIndex],
      floatingActionButton: SizedBox(
        height: 56.h,
        width: 56.w,
        child: FloatingActionButton(
          backgroundColor: kprimaryColor,
          shape: const CircleBorder(),
          onPressed: () => Navigator.pushNamed(context, CreateAdScreen.id),
          child: SvgPicture.asset(
            addIcon,
            height: 24.h,
            width: 24.w,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          AnimatedBottomNavigationBar.builder(
            height: 83.h,
            itemCount: unselectedIcons.length,
            tabBuilder: (int index, bool isActive) {
              return GestureDetector(
                onTap: () => bottomNavProvider.setIndex(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16.h),
                    SvgPicture.asset(
                      isActive ? selectedIcons[index] : unselectedIcons[index],
                      width: 24.sp,
                      height: 24.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: isActive ? kprimaryColor : grey4,
                      ),
                    ),
                  ],
                ),
              );
            },
            activeIndex: bottomNavProvider.currentIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            backgroundColor: Colors.white,
            onTap: (index) => bottomNavProvider.setIndex(index),
          ),
          Positioned(
              top: 34.h,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'انشاء اعلان',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                ),
              ))
        ],
      ),
    );
  }
}
