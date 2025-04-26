import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/models/user.dart';
import '../../ads/widgets/products-details.dart';
import '../../home/data.dart';
import '../../home/provider.dart';
import '../../home/widgets/product-item.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  final User user;
  const CustomDraggableScrollableSheet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeProvider.loadAds();
    });

    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.1,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
                              Text(
                                '${user.firstName} ${user.lastName}',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                " عضو منذ${user.createdAt}",
                                style: TextStyle(fontSize: 14.sp, color: grey4),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          CircleAvatar(
                              radius: 30.r,
                              backgroundImage:
                                  NetworkImage(user.profilePicture ?? '')),
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
                    onPressed: () =>
                        Navigator.pushNamed(context, ConversationScreen.id),
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
                              width: 120.w,
                              height: 130.h,
                              hasDiscount: false,
                              product: product,
                              category: product.categoryNamePath ?? '',
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  //     const ProductsDetails(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
