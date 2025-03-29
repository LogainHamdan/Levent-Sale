import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../provider.dart';

class FollowTile extends StatelessWidget {
  final int index;

  const FollowTile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FollowProvider>(context);
    return ListTile(
        trailing: CircleAvatar(
          backgroundImage:
              AssetImage('assets/imgs_icons/home/assets/imgs/بسمة.png'),
        ),
        horizontalTitleGap: 3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.verified, color: kprimaryColor, size: 16.sp),
            SizedBox(width: 5.w),
            Text(
              'بسمة باسم',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ],
        ),
        subtitle: Text(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            'عضو منذ يناير 2024'),
        leading: SizedBox(
          width: 130.w,
          child: CustomElevatedButton(
              fontSize: 16,
              text: provider.isFollowing(index) ? 'إلغاء المتابعة' : 'متابعة',
              onPressed: () => provider.toggleFollow(index),
              backgroundColor:
                  provider.isFollowing(index) ? grey7 : kprimaryColor,
              textColor: provider.isFollowing(index) ? Colors.black : grey9),
        ));
  }
}
