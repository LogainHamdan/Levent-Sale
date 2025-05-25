import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../create-ad/create-ad.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCollectionScreenProvider>(
        builder: (context, provider, child) {
      return provider.currentTabLoading || provider.isLoadingPending
          ? const Center(child: CustomCircularProgressIndicator())
          : provider.pendingAds.isEmpty
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16.h),
                      EmptyWidget(
                        msg: 'لا توجد اعلانات قيد المراجعة',
                        img: emptyAdsIcon,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                          child: CustomElevatedButton(
                            text: 'ابدأ في انشاء إعلانك',
                            onPressed: () =>
                                Navigator.pushNamed(context, CreateAdScreen.id),
                            backgroundColor: kprimaryColor,
                            textColor: grey9,
                            date: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ItemList(
                  provider.currentTabTitle,
                  provider.currentTabColor,
                  buttonIcon: provider.currentTabIcon,
                  buttonTextColor: provider.currentTabTextColor,
                  ads: provider.pendingAds,
                );
    });
  }
}
