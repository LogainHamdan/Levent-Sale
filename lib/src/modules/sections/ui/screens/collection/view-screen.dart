import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCollectionScreenProvider>(
        builder: (context, provider, child) {
      return provider.currentTabLoading || provider.isLoadingPending
          ? const Center(child: CustomCircularProgressIndicator())
          : provider.pendingAds.isEmpty
              ? const Center(child: Text('لا توجد إعلانات قيد المراجعة'))
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
