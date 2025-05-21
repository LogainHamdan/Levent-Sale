import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/models/profile.dart';
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
  final int userId;

  const FollowTile({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return FutureBuilder(
        future: provider.getUserById(id: userId),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomCircularProgressIndicator();
          }
          print('user in follow tile : id $userId ${user?.toJson()}');
          return ListTile(
            trailing: CircleAvatar(
              radius: 24.r,
              backgroundImage: NetworkImage(user?.profilePicture ?? ''),
              backgroundColor: Colors.transparent,
            ),
            horizontalTitleGap: 3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (user?.isVerified ?? false)
                  SvgPicture.asset(verifiedGreenIcon),
                SizedBox(
                  width: 120.w,
                  child: Text(
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    '${user?.firstName} ${user?.lastName}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            // subtitle: Text(
            //   'عضو منذ ${user?.createdAt ?? ''}',
            //   textAlign: TextAlign.right,
            //   textDirection: TextDirection.rtl,
            // ),
            leading: SizedBox(
              width: 130.w,
              child: Consumer<FollowProvider>(
                builder: (context, followProvider, child) =>
                    CustomElevatedButton(
                  fontSize: 16.sp,
                  text:
                      user?.isFollowing ?? false ? 'إلغاء المتابعة' : 'متابعة',
                  onPressed: user?.isFollowing ?? false
                      ? () async {
                          final token = await TokenHelper.getToken();
                          print(
                              'to invoke toggle: id: ${userId} and token: $token}');
                          print('is following: ${user?.isFollowing}');

                          followProvider.unfollowProfile(
                              followingId: userId, token: token ?? "");
                        }
                      : () async {
                          final token = await TokenHelper.getToken();
                          if (token == null || token.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: errorColor,
                              content: Text('قم بتسجيل الدخول اولاً'),
                            ));
                            return;
                          }
                          print(
                              'to invoke toggle: id: ${userId} and token: $token}');
                          followProvider.followProfile(
                              followingId: userId, token: token ?? "");
                        },
                  backgroundColor:
                      user?.isFollowing ?? false ? grey7 : kprimaryColor,
                  textColor: user?.isFollowing ?? false ? Colors.black : grey9,
                ),
              ),
            ),
          );
        });
  }
}
