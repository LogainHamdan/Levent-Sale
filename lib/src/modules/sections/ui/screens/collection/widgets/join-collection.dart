import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import '../edit-screen.dart';
import '../review-screen.dart';
import '../view-screen.dart';

class JoinMyCollection extends StatelessWidget {
  const JoinMyCollection({super.key});

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
                  tab3: 'قيد المراجعة')),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 16.h),
        ),
        SliverFillRemaining(
          child: PageView(
            controller: provider.pageController,
            onPageChanged: provider.updateIndex,
            children: const [
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
