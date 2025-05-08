import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../home/ui/screens/home/widgets/banner.dart';

class Sections extends StatelessWidget {
  static const id = '/sections';

  const Sections({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,

      extendBody: true,

      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          noBack: true,
          title: 'الاقسام',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopBanner(),
                SizedBox(
                  height: 20.h,
                ),
                CategoriesDisplay(
                  onSectionClicked: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
