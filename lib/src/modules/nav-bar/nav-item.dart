import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import 'nav_provider.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isHome;

  const NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    this.isHome = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<NavigationProvider>();
    bool isSelected = provider.selectedIndex == index;

    return GestureDetector(
      onTap: () => provider.setIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? kprimaryColor : grey4, size: 28.sp),
          SizedBox(height: 4.h),
          Text(label,
              style: TextStyle(
                  color: isSelected ? kprimaryColor : grey5, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
