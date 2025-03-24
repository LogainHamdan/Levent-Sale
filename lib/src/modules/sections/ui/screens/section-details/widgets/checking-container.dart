import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/login/widgets/checkbox.dart';
import '../provider.dart';
import 'custom-label.dart';

class CheckingContainer extends StatelessWidget {
  const CheckingContainer({
    super.key,
    required this.provider,
  });

  final SectionDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: grey8,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomLabel(
              text: "توفر الخدمات والمرافق",
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: provider.services.keys.map((key) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomCheckBox(
                    title: key,
                    value: provider.services[key]!,
                    onChanged: (value) => provider.toggleService(key, value),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
