import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameRow extends StatelessWidget {
  final String name;
  final bool? isVerified;
  final String image;
  final Color? nameColor;
  const NameRow({
    super.key,
    required this.name,
    this.isVerified = false,
    required this.image,
    this.nameColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isVerified! ? Icon(Icons.verified, color: Colors.white) : SizedBox(),
        SizedBox(
          width: 12.w,
        ),
        Text(
          name,
          style: TextStyle(color: nameColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 12.w,
        ),
        Positioned(
          bottom: -20.h,
          right: 16.r,
          child: CircleAvatar(
            radius: 34.r,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 32.r,
              backgroundImage: AssetImage(image),
            ),
          ),
        ),
      ],
    );
  }
}
