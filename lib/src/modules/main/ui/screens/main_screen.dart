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
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const id = '/main';
  const MainScreen({super.key});

  final List<IconData> iconList = const [
    CupertinoIcons.square_grid_2x2,
    Icons.shopping_bag_outlined,
    Icons.menu,
    Icons.home_filled
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kprimaryColor,
        shape: const CircleBorder(),
        onPressed: () => Navigator.pushNamed(context, CreateAdScreen.id),
        child: Icon(Icons.add, color: Colors.white, size: 35.sp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 60.h,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return GestureDetector(
            onTap: () => bottomNavProvider.setIndex(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconList[index],
                    size: isActive ? 24.sp : 24.sp,
                    color: isActive ? kprimaryColor : grey4),
                SizedBox(height: 4.h),
                Text(
                  labels[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
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
    );
  }
}
