import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/delete-account.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WhyToDeleteScreen extends StatelessWidget {
  static const id = '/why';

  const WhyToDeleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => DeleteProvider(),
        child: Scaffold(
          appBar: AppBar(
            titleTextStyle: Theme.of(context).textTheme.bodyLarge,
            title: TitleRow(
                onBackTap: () => Navigator.pushReplacementNamed(
                    context, DeleteAccountScreen.id),
                title: 'حذف الحساب'),
            leading: SizedBox(),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "لماذا تريد حذف حسابك ؟",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Consumer<DeleteProvider>(
                  builder: (context, provider, child) {
                    final reasons = [
                      "تجربة مستخدم غير مرضية",
                      "مشاكل تقنية متكررة",
                      "خدمة العملاء غير فعالة",
                    ];

                    return Column(
                      children: List.generate(reasons.length, (index) {
                        return GestureDetector(
                          onTap: () => provider.selectReason(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 10.w),
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: grey8,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  provider.selectedReason == index
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_off,
                                  color: provider.selectedReason == index
                                      ? kprimaryColor
                                      : Colors.grey,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  reasons[index],
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
                SizedBox(height: 20.sp),
                CustomElevatedButton(
                  text: 'حذف الحساب',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'تم حذف الحساب بنجاح',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        backgroundColor: kprimaryColor,
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushReplacementNamed(context, SplashScreen.id);
                    });
                  },
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
