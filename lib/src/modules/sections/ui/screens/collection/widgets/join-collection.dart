import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../edit-screen.dart';
import '../review-screen.dart';
import '../view-screen.dart';

class JoinMyCollection extends StatelessWidget {
  final bool isLoadingPublished;
  final bool isLoadingPending;
  final bool isLoadingRejected;
  final List publishedAds;
  final List pendingAds;
  final List rejectedAds;

  const JoinMyCollection({
    super.key,
    required this.isLoadingPublished,
    required this.isLoadingPending,
    required this.isLoadingRejected,
    required this.publishedAds,
    required this.pendingAds,
    required this.rejectedAds,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyCollectionScreenProvider>(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
              height: 60.h,
              child: const TabBarWidget(
                  info: false,
                  chats: false,
                  tab1: 'المرفوضة',
                  tab2: 'المقبولة',
                  tab4: "",
                  tab3: 'قيد المراجعة')),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        SliverFillRemaining(
          child: PageView(
            controller: provider.pageController,
            onPageChanged: provider.updateIndex,
            children: [
              ReviewScreen(),
              EditScreen(),
              ViewScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
