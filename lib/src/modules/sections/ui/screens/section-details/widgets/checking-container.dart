import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/login/widgets/checkbox.dart';
import '../../../../models/attriburtes.dart';
import '../provider.dart';
import 'custom-label.dart';

class CheckingContainer extends StatelessWidget {
  const CheckingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAdSectionDetailsProvider>(context);

    final attributesData = createProvider.attributesData;

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
                    createProvider.toggleService(detail, value);
                  },
                  value: createProvider.isServiceSelected(detail),
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
