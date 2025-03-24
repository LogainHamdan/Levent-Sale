import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../sections/ui/screens/collection/my-collection.dart';
import 'nav_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IconData> iconList = [
      Icons.home,
      Icons.grid_view,
      Icons.shopping_bag_outlined,
      Icons.menu,
    ];
    final List<Widget> screens = [
      HomeScreen(),
      Sections(),
      MyCollectionScreen(
        empty: false,
      ),
      ProfileScreen(),
    ];
    final List<String> labels = [
      "الرئيسية",
      "الأقسام",
      "تشكيلتي",
      "المزيد",
    ];
    var provider = context.watch<NavigationProvider>();

    return SafeArea(
      child: Scaffold(
        body: screens[provider.selectedIndex],
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 8.0.h),
          child: FloatingActionButton(
            backgroundColor: kprimaryColor,
            shape: CircleBorder(),
            onPressed: () => Navigator.pushNamed(context, CreateAdScreen.id),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35.sp,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3.r,
                    spreadRadius: 1.r,
                  ),
                ],
              ),
              child: AnimatedBottomNavigationBar.builder(
                height: 60.h,
                itemCount: screens.length,
                tabBuilder: (int index, bool isActive) {
                  return GestureDetector(
                    onTap: () {
                      provider.setIndex(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            iconList[index],
                            size: 24.sp,
                            color: isActive ? kprimaryColor : grey4,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            labels[index],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight:
                                  isActive ? FontWeight.bold : FontWeight.w500,
                              color: isActive ? kprimaryColor : grey4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                activeIndex: provider.selectedIndex,
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.smoothEdge,
                onTap: (index) {
                  provider.setIndex(index);
                },
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              bottom: 10.h,
              child: Text(
                'إنشاء إعلان',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// clipBehavior: Clip.none,
// alignment: AlignmentDirectional.topCenter,
// children: [
// Positioned(
// bottom: 0,
// left: 0,
// right: 0,
// child: Container(
// height: 75.h,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: grey7,
// blurRadius: 10.r,
// spreadRadius: 5.r,
// ),
// ],
// ),
// ),
// ),
// ClipPath(
// clipper: BottomBarClipper(),
// child: Container(
// height: 70.h,
// decoration: BoxDecoration(
// color: Colors.white,
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// NavItem(
// onTap: () {}, icon: Icons.menu, label: "المزيد", index: 4),
// NavItem(
// onTap: () {},
// icon: Icons.shopping_bag,
// label: "تشكيلتي",
// index: 3),
// Padding(
// padding: EdgeInsets.only(top: 63),
// child: Text(
// 'انشاء اعلان',
// style: TextStyle(
// color: grey0,
// fontSize: 14.sp,
// fontWeight: FontWeight.w500),
// ),
// ),
// NavItem(
// onTap: () => Navigator.pushReplacementNamed(
// context, SectionChoose.id),
// icon: Icons.grid_view,
// label: "الأقسام",
// index: 1),
// NavItem(
// onTap: () =>
// Navigator.pushReplacementNamed(context, HomeScreen.id),
// icon: Icons.home,
// label: "الرئيسية",
// index: 0,
// isHome: true),
// ],
// ),
// ),
// ),
// Positioned(
// bottom: 20.h,
// child: GestureDetector(
// onTap: () => provider.setIndex(2),
// child: Container(
// width: 70.w,
// height: 70.h,
// decoration: BoxDecoration(
// color: kprimaryColor,
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(color: Colors.black26, blurRadius: 10.r),
// ],
// ),
// child: Icon(Icons.add, color: Colors.white, size: 35.sp),
// ),
// ),
// ),
// ],
// );
