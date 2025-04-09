import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
          SvgPicture.asset(verifiedGreenIcon),
          SizedBox(width: 5.w),
          Text(
            'بسمة باسم',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
      subtitle: Text(
        'عضو منذ يناير 2024',
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      leading: SizedBox(
        width: 130.w,
        child: CustomElevatedButton(
          fontSize: 16,
          text: provider.followingUsers[index].isFollowing
              ? 'إلغاء المتابعة'
              : 'متابعة',
          onPressed: () => provider.toggleFollow(index),
          backgroundColor: provider.followingUsers[index].isFollowing
              ? grey7
              : kprimaryColor,
          textColor:
              provider.followingUsers[index].isFollowing ? Colors.black : grey9,
        ),
      ),
    );
  }
}
