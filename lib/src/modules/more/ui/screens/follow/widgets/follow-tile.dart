import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';

import '../../../../models/followers.dart';
import '../../../../models/following.dart';
import '../provider.dart';

class FollowTile extends StatelessWidget {
  final dynamic user;
  final int index;

  const FollowTile({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FollowProvider>(context, listen: false);

    return ListTile(
      trailing: CircleAvatar(
        child: SvgPicture.asset(user.profilePicture),
      ),
      horizontalTitleGap: 3,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(verifiedGreenIcon),
          SizedBox(width: 5.w),
          Text(
            '${user.firstName} ${user.lastName}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
      subtitle: Text(
        'عضو منذ ${user.birthday}',
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      leading: SizedBox(
        width: 130.w,
        child: CustomElevatedButton(
          fontSize: 16.sp,
          text: user.isFollowing ? 'إلغاء المتابعة' : 'متابعة',
          onPressed: () async {
            final token = await TokenHelper.getToken();
            if (token == null || token.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: errorColor,
                  content: Text('قم بتسجيل الدخول اولاً')));
              return;
            }
            await provider.toggleFollowProfile(context,
                followingId: user.id, token: token ?? '');
          },
          backgroundColor: user.isFollowing ? grey7 : kprimaryColor,
          textColor: user.isFollowing ? Colors.black : grey9,
        ),
      ),
    );
  }
}
