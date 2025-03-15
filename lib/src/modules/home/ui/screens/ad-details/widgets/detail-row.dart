import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.title,
    required this.value,
    required this.bgColor,
  });

  final String title;
  final String value;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      color: bgColor, // Solid background color for each row
      child: Row(
        textDirection: TextDirection.rtl, // Ensures proper RTL layout
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: grey4),
              textAlign: TextAlign.right, // Aligns text to the right
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: grey1),
              textAlign: TextAlign.right, // Aligns text to the right
            ),
          ),
        ],
      ),
    );
  }
}
