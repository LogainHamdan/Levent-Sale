import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../../../models/profile.dart';

class personalInfoContainer extends StatelessWidget {
  const personalInfoContainer({
    super.key,
    required this.userToShow,
  });

  final Profile userToShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: grey8,),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(userToShow.phoneNumber ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 14.w),
                const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(userToShow.email ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 14.w),
                const Icon(Icons.email),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    '${userToShow.address?.governorate?.governorateName ?? ''} - ${userToShow.address?.city?.cityName ?? ''}',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 14.w),
                const Icon(Icons.location_on),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
