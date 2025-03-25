import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const id = '/main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return Scaffold(
      body: screens[_bottomNavIndex],
      // body: IndexedStack(
      //   index: _bottomNavIndex,
      //   children: screens,
      // ),
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
    );
  }
}
