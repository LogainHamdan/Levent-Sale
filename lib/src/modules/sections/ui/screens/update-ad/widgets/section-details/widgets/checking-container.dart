import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/constants.dart';
import '../../../../../../../auth/ui/screens/login/widgets/checkbox.dart';
import '../provider.dart';

class CheckingContainerUpdate extends StatelessWidget {
  const CheckingContainerUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateAdSectionDetailsProvider>(context);

    final attributesData = provider.attributesData;

    if (attributesData == null || attributesData.details == null) {
      return const SizedBox.shrink();
    }

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
            Column(
              children: (attributesData.details ?? []).map((detail) {
                final serviceTitle = detail.name?.isNotEmpty == true
                    ? detail.name
                    : 'خدمة غير معروفة';

                return CustomCheckBox(
                  onChanged: (value) {
                    provider.toggleService(detail, value);
                  },
                  value: provider.isServiceSelected(detail),
                  title: Text(
                    textDirection: TextDirection.rtl,
                    serviceTitle!,
                    style: GoogleFonts.tajawal(
                        fontSize: 14, fontWeight: FontWeight.w500),
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
