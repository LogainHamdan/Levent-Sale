import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import 'detail-row.dart';

class DetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      // Ensures full RTL layout
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          DetailRow(title: 'النوع', value: 'آيفون', bgColor: grey8),
          DetailRow(title: 'الحالة', value: 'مستعمل', bgColor: grey6),
          DetailRow(
              title: 'نوع السعر', value: 'قابل للنقاش', bgColor: grey8),
          DetailRow(title: 'مودل', value: 'موديل آخر', bgColor: grey6),
        ],
      ),
    );
  }
}
