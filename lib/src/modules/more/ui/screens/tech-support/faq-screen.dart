import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/widgets/custom-expansion-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../../home/ui/screens/home/widgets/search-field.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  late Future<void> _faqFuture;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TechSupportProvider>(context, listen: false);
    _faqFuture = provider.getFAQs();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TechSupportProvider>(context);

    return FutureBuilder(
      future: _faqFuture,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
            child: Column(
              children: [
                // SizedBox(height: 16.h),
                // SearchField(width: 370.w, controller: faqController),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 700.h,
                  child: ListView.builder(
                    itemCount: provider.faqs.length,
                    itemBuilder: (context, index) {
                      final faq = provider.faqs[index];
                      return FutureBuilder<String>(
                        future: provider.getAnswerFAQ(id: faq.id ?? ''),
                        builder: (context, answerSnapshot) {
                          if (answerSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CustomCircularProgressIndicator();
                          } else if (answerSnapshot.hasError) {
                            return CustomExpansionTile(
                              title: faq.question ?? '',
                              content: 'Error: ${answerSnapshot.error}',
                            );
                          } else {
                            return CustomExpansionTile(
                              title: faq.question ?? '',
                              content:
                                  answerSnapshot.data ?? 'No answer available',
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
