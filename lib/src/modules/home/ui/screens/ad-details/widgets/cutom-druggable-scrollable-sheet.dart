import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/friend-profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../home/provider.dart';
import '../../home/widgets/product-item.dart';

class CustomDraggableScrollableSheet extends StatefulWidget {
  final int userId;
  final int adId;

  const CustomDraggableScrollableSheet(
      {super.key, required this.userId, required this.adId});

  @override
  _CustomDraggableScrollableSheetState createState() =>
      _CustomDraggableScrollableSheetState();
}

class _CustomDraggableScrollableSheetState
    extends State<CustomDraggableScrollableSheet> {
  String? token;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    token = await TokenHelper.getToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    print('user passed: ${widget.userId}');

    return FutureBuilder(
        future: profileProvider.getProfile(userId: widget.userId),
        builder: (context, snapshot) {
          final profile = snapshot.data;
          return DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.1,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.r,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 5.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: grey7,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 50.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    color: greySplash,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.call,
                                      color: kprimaryColor,
                                      size: 18.sp,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      child: Text(
                                        textDirection: TextDirection.rtl,
                                        '${profile?.username}',
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      " عضو منذ${profile?.birthday ?? ''}",
                                      style: TextStyle(
                                          fontSize: 14.sp, color: grey4),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () async {
                                    final currentUser =
                                        await UserHelper.getUser();
                                    final user = await loginProvider
                                        .getUserById(id: widget.userId);
                                    print(
                                        'user beforei call: ${widget.userId}');
                                    if (user != null) {
                                      user.id != currentUser?.id
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FriendProfile(
                                                        userId: widget.userId),
                                              ),
                                            )
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileScreen(
                                                        userId:
                                                            currentUser?.id ??
                                                                0,
                                                      )),
                                            );
                                    }
                                  },
                                  child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage: NetworkImage(
                                          profile?.profilePicture ?? '')),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomElevatedButton(
                          icon: SvgPicture.asset(
                            chatWhiteIcon,
                            height: 20.h,
                          ),
                          text: 'محادثة',
                          onPressed: () async {
                            final user = await UserHelper.getUser();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConversationScreen(
                                  adId: widget.adId,
                                  userId: user?.id ?? 0,
                                  receiverId: widget.userId,
                                ),
                              ),
                            );
                          },
                          backgroundColor: kprimaryColor,
                          textColor: grey9,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: homeProvider.allAds
                              .skip([].length > 2 ? [].length - 2 : 0)
                              .map(
                                (product) => Padding(
                                  padding: EdgeInsets.only(left: 16.0.w),
                                  child: ProductItem(
                                    height: 120.h,
                                    hasDiscount: false,
                                    product: product,
                                    category: product.categoryNamePath ?? '',
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
