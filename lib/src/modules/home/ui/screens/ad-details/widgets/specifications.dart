import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecificationsSection extends StatelessWidget {
  final String title;
  final List<String> specifications;

  const SpecificationsSection({
    Key? key,
    required this.title,
    required this.specifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.right, // Aligns the title properly
          ),
          SizedBox(height: 5.h),
          ...specifications.map((spec) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Align(
                  alignment:
                      Alignment.centerRight, // Ensures full RTL alignment
                  child: Text(
                    '- $spec',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right, // Aligns text correctly
                    textDirection: TextDirection.rtl, // Forces RTL direction
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
