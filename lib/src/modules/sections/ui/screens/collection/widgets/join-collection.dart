import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../edit-screen.dart';
import '../provider.dart';
import '../review-screen.dart';
import '../view-screen.dart';

class JoinMyCollection extends StatelessWidget {
  const JoinMyCollection({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyCollectionScreenProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: 60.h,
          child: TabBarWidget(),
        ),
        SizedBox(height: 16.h),
        Expanded(
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
