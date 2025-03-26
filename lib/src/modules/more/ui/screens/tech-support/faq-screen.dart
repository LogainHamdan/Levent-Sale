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
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            SearchField(
              controller: faqController,
            ),
            SizedBox(
              height: 30.h,
            ),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                itemCount: 5,
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
