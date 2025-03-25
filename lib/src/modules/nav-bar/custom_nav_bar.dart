import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../more/ui/screens/menu/menu.dart';
import '../sections/ui/screens/collection/my-collection.dart';
import 'nav_provider.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _bottomNavIndex = 0;

  final List<IconData> iconList = [
    Icons.home,
    Icons.grid_view,
    Icons.shopping_bag_outlined,
    Icons.menu,
  ];

  final List<Widget> screens = [
    HomeScreen(),
    Sections(),
    MyCollectionScreen(empty: false),
    MenuScreen(),
  ];

  final List<String> labels = [
    "الرئيسية",
    "الأقسام",
    "تشكيلتي",
    "المزيد",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _bottomNavIndex,
          children: screens,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kprimaryColor,
          shape: const CircleBorder(),
          onPressed: () => Navigator.pushNamed(context, CreateAdScreen.id),
          child: const Icon(Icons.add, color: Colors.white, size: 35),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: 60,
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            return GestureDetector(
              onTap: () => setState(() => _bottomNavIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(iconList[index],
                      size: 24, color: isActive ? kprimaryColor : grey4),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive ? kprimaryColor : grey4,
                    ),
                  ),
                ],
              ),
            );
          },
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          backgroundColor: Colors.white,
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }
}

//
// // clipBehavior: Clip.none,
// // alignment: AlignmentDirectional.topCenter,
// // children: [
// // Positioned(
// // bottom: 0,
// // left: 0,
// // right: 0,
// // child: Container(
// // height: 75.h,
// // decoration: BoxDecoration(
// // boxShadow: [
// // BoxShadow(
// // color: grey7,
// // blurRadius: 10.r,
// // spreadRadius: 5.r,
// // ),
// // ],
// // ),
// // ),
// // ),
// // ClipPath(
// // clipper: BottomBarClipper(),
// // child: Container(
// // height: 70.h,
// // decoration: BoxDecoration(
// // color: Colors.white,
// // ),
// // child: Row(
// // mainAxisAlignment: MainAxisAlignment.spaceAround,
// // children: [
// // NavItem(
// // onTap: () {}, icon: Icons.menu, label: "المزيد", index: 4),
// // NavItem(
// // onTap: () {},
// // icon: Icons.shopping_bag,
// // label: "تشكيلتي",
// // index: 3),
// // Padding(
// // padding: EdgeInsets.only(top: 63),
// // child: Text(
// // 'انشاء اعلان',
// // style: TextStyle(
// // color: grey0,
// // fontSize: 14.sp,
// // fontWeight: FontWeight.w500),
// // ),
// // ),
// // NavItem(
// // onTap: () => Navigator.pushReplacementNamed(
// // context, SectionChoose.id),
// // icon: Icons.grid_view,
// // label: "الأقسام",
// // index: 1),
// // NavItem(
// // onTap: () =>
// // Navigator.pushReplacementNamed(context, HomeScreen.id),
// // icon: Icons.home,
// // label: "الرئيسية",
// // index: 0,
// // isHome: true),
// // ],
// // ),
// // ),
// // ),
// // Positioned(
// // bottom: 20.h,
// // child: GestureDetector(
// // onTap: () => provider.setIndex(2),
// // child: Container(
// // width: 70.w,
// // height: 70.h,
// // decoration: BoxDecoration(
// // color: kprimaryColor,
// // shape: BoxShape.circle,
// // boxShadow: [
// // BoxShadow(color: Colors.black26, blurRadius: 10.r),
// // ],
// // ),
// // child: Icon(Icons.add, color: Colors.white, size: 35.sp),
// // ),
// // ),
// // ),
// // ],
// // );
