import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onTap;
  final bool isHeader;
  final Color color;
  final bool? bold;
  const OptionTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.bold = false,
    this.isHeader = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        width: double.infinity,
        alignment: Alignment.centerRight,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: bold! ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            icon,
          ],
        ),
      ),
    );
  }
}
