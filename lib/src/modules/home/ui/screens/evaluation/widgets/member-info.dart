import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class MemberInfo extends StatelessWidget {
  final String name;
  final String memberSince;
  final String date;
  const MemberInfo({
    super.key,
    required this.memberSince,
    required this.date,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        CircleAvatar(
          backgroundImage:
              AssetImage('assets/imgs_icons/home/assets/imgs/منال.png'),
          radius: 28.r,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              name,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'عضو منذ ${memberSince}',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        Text(
          date,
          style: TextStyle(color: grey4),
        ),
      ],
    );
  }
}
