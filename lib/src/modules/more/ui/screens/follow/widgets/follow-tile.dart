import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/models/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
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
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    return FutureBuilder(
        future: provider.getUserById(id: userId),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomCircularProgressIndicator();
          }
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
                builder: (context, followProvider, child) => FutureBuilder(
                  future: profileProvider.getProfile(userId: userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomCircularProgressIndicator();
                    }
                    final profile = snapshot.data;
                    return CustomElevatedButton(
                      fontSize: 14.sp,
                      text: profile?.following ?? false
                          ? 'إلغاء المتابعة'
                          : 'متابعة',
                      onPressed: profile?.following ?? false
                          ? () async {
                              final token = await TokenHelper.getToken();
                              print(
                                  'to invoke toggle: id: ${userId} and token: $token}');
                              print('is following: ${profile?.following}');

                              followProvider.unfollowProfile(
                                  followingId: userId, token: token ?? "");
                            }
                          : () async {
                              final token = await TokenHelper.getToken();
                              if (token == null || token.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
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
                          profile?.following ?? false ? grey7 : kprimaryColor,
                      textColor:
                          profile?.following ?? false ? Colors.black : grey9,
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
