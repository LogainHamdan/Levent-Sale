import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import 'custom_clipper.dart';
import 'nav-item.dart';
import 'nav_provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NavigationProvider>();

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 75.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: grey7,
                  blurRadius: 10.r,
                  spreadRadius: 5.r,
                ),
              ],
            ),
          ),
        ),
        ClipPath(
          clipper: BottomBarClipper(),
          child: Container(
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(icon: Icons.menu, label: "المزيد", index: 4),
                NavItem(icon: Icons.shopping_bag, label: "تشكيلتي", index: 3),
                Padding(
                  padding: EdgeInsets.only(top: 63),
                  child: Text(
                    'انشاء اعلان',
                    style: TextStyle(
                        color: grey0,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                NavItem(icon: Icons.grid_view, label: "الأقسام", index: 1),
                NavItem(
                    icon: Icons.home,
                    label: "الرئيسية",
                    index: 0,
                    isHome: true),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          child: GestureDetector(
            onTap: () => provider.setIndex(2),
            child: Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: kprimaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10.r),
                ],
              ),
              child: Icon(Icons.add, color: Colors.white, size: 35.sp),
            ),
          ),
        ),
      ],
    );
  }
}
