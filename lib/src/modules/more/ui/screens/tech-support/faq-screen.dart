import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/widgets/custom-expansion-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../home/ui/screens/home/widgets/search-field.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController faqController = TextEditingController();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            SearchField(
              width: 370.w,
              controller: faqController,
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 700.h,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return CustomExpansionTile(
                      title: 'هل علي تسجيل حساب في السوق المفتوحة؟',
                      content:
                          "يمكنك التصفح بدون حساب، ولكن لتتمكن من نشر الإعلانات تحتاج إلى تسجيل حساب.");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
