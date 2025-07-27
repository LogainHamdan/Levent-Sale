import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/models/user.dart';

class MemberInfo extends StatelessWidget {
  final User user;
  final String date;
  const MemberInfo({
    super.key,
    required this.date,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user?.profilePicture ?? ''),
          radius: 28.r,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              user?.username ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'عضو منذ ${user?.createdAt != null ? DateFormat('yyyy-MM-dd').format(user!.createdAt!) : ''}',
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
