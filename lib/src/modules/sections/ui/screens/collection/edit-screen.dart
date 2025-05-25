import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyCollectionScreenProvider>(
        builder: (context, provider, child) {
      return provider.currentTabLoading || provider.isLoadingPublished
          ? const Center(child: CustomCircularProgressIndicator())
          : provider.publishedAds.isEmpty
              ? const Center(child: Text('لا توجد إعلانات مقبولة'))
              : ItemList(
                  provider.currentTabTitle,
                  provider.currentTabColor,
                  buttonIcon: provider.currentTabIcon,
                  buttonTextColor: provider.currentTabTextColor,
                  ads: provider.publishedAds,
                );
    });
  }
}
