import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleTitle extends StatelessWidget {
  final String title;
  const SimpleTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          Alignment.centerRight, // Align the text to the right of the parent
      child: Text(
        textDirection: TextDirection.rtl,
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
