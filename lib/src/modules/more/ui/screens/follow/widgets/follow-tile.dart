import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../models/followers.dart';
import '../models/following.dart';
import '../provider.dart';

class FollowTile extends StatelessWidget {
  final FollowerModel follower;
  final FollowedUserModel followedUser;
  final int index;

  const FollowTile(
      {super.key,
      required this.follower,
      required this.index,
      required this.followedUser});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FollowProvider>(context);

    return ListTile(
      trailing: CircleAvatar(
        child: SvgPicture.asset(follower.profilePicture),
      ),
      horizontalTitleGap: 3,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(verifiedGreenIcon),
          SizedBox(width: 5.w),
          Text(
            '${follower.firstName} ${follower.lastName}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
      subtitle: Text(
        'عضو منذ ${follower.birthday}',
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      leading: SizedBox(
        width: 130.w,
        child: CustomElevatedButton(
          fontSize: 16.sp,
          text: followedUser.isFollowing ? 'إلغاء المتابعة' : 'متابعة',
          onPressed: () => provider.toggleFollow(index),
          backgroundColor: followedUser.isFollowing ? grey7 : kprimaryColor,
          textColor: followedUser.isFollowing ? Colors.black : grey9,
        ),
      ),
    );
  }
}
