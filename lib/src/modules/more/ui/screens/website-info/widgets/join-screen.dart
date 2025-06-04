import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/about-us.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/privacy-policy.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class JoinWebsiteInfo extends StatelessWidget {
  const JoinWebsiteInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WebsiteInfoProvider>(context, listen: false);

    return Column(
      children: [
        SizedBox(
            height: 60.h,
            child: const TabBarWidget(
                chats: false,
                info: true,
                tab1: 'من نحن',
                tab2: 'سياسة الخصوصية',
                tab3: '')),
        SizedBox(height: 16.h),
        Expanded(
          child: PageView(
            controller: provider.pageController,
            onPageChanged: provider.updateIndex,
            children: const [AboutUs(), PrivacyPolicy()],
          ),
        ),
      ],
    );
  }
}
