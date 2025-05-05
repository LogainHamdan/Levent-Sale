import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/more/models/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/models/user.dart';
import '../../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';

import '../../../../models/follow.dart';
import '../provider.dart';

class FollowTile extends StatelessWidget {
  final FollowProfileModel profile;

  const FollowTile({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return FutureBuilder(
        future: provider.getUserById(id: profile.id),
        builder: (context, snapshot) {
          final user = snapshot.data;
          return ListTile(
            trailing: CircleAvatar(
              radius: 24.r,
              backgroundImage: NetworkImage(profile.profilePicture ?? ''),
              backgroundColor: Colors.transparent,
            ),
            horizontalTitleGap: 3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(verifiedGreenIcon),
                SizedBox(width: 5.w),
                SizedBox(
                  width: 120.w,
                  child: Text(
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    '${profile.firstName} ${profile.lastName}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              //   'عضو منذ ${user.createdAt ?? ''}',
              '',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            leading: SizedBox(
              width: 130.w,
              child: CustomElevatedButton(
                fontSize: 16.sp,
                text: user?.isFollowing ?? false ? 'إلغاء المتابعة' : 'متابعة',
                onPressed: user?.isFollowing ?? false
                    ? () async {
                        final followProvider =
                            Provider.of<FollowProvider>(context, listen: false);
                        final token = await TokenHelper.getToken();
                        print(
                            'to invoke toggle: id: ${profile.id} and token: $token}');
                        followProvider.followProfile(context,
                            followingId: profile.id ?? 0, token: token ?? "");
                      }
                    : () async {
                        final followProvider =
                            Provider.of<FollowProvider>(context, listen: false);

                        final token = await TokenHelper.getToken();
                        if (token == null || token.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: errorColor,
                            content: Text('قم بتسجيل الدخول اولاً'),
                          ));
                          return;
                        }
                        print(
                            'to invoke toggle: id: ${profile.id} and token: $token}');
                        followProvider.unfollowProfile(context,
                            followingId: profile.id, token: token ?? "");
                      },
                backgroundColor:
                    user?.isFollowing ?? false ? grey7 : kprimaryColor,
                textColor: user?.isFollowing ?? false ? Colors.black : grey9,
              ),
            ),
          );
        });
  }
}
