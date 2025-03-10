import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double width = size.width;
    double height = size.height;

    path.lineTo((width / 3) - 75, 0);

    path.arcToPoint(
      Offset((width / 2) - 40, 40),
      radius: Radius.circular(90),
      clockwise: true,
    );

    path.arcToPoint(
      Offset((width / 2) + 40, 40),
      radius: Radius.circular(45),
      clockwise: false,
    );

    path.arcToPoint(
      Offset((width / 2) + 90, 0),
      radius: Radius.circular(100),
      clockwise: true,
    );

    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BottomBarClipper oldClipper) => false;
}
