import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../ads/widgets/products-details.dart';

class CustomDraggableScrollableSheet extends StatelessWidget {
  const CustomDraggableScrollableSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.1,
      maxChildSize: 0.8,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
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
                              color: grey7,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.call, color: kprimaryColor),
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
                                "بسمة باسم",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "عضو منذ يناير 2024",
                                style: TextStyle(fontSize: 14.sp, color: grey4),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: AssetImage(
                                'assets/imgs_icons/home/assets/imgs/بسمة.png'),
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
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, ConversationScreen.id),
                    backgroundColor: kprimaryColor,
                    textColor: grey9,
                  ),
                  SizedBox(height: 20.h),
                  const ProductsDetails(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
