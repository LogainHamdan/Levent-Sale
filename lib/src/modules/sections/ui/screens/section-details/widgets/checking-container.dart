import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/login/widgets/checkbox.dart';
import '../../../../models/attriburtes.dart';
import '../create-ad-section-details.dart';
import '../update-ad-section-details.dart';
import 'custom-label.dart';

class CheckingContainer extends StatelessWidget {
  final bool create;
  const CheckingContainer({
    super.key,
    required this.create,
  });

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAdSectionDetailsProvider>(context);
    final updateProvider = Provider.of<UpdateAdSectionDetailsProvider>(context);

    final attributesData =
        create ? createProvider.attributesData : updateProvider.attributesData;

    if (attributesData == null) {
      return const SizedBox.shrink();
    }

    final services = create ? createProvider.services : updateProvider.services;

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
              children: services.entries.map((entry) {
                final detail = (attributesData.details ?? []).firstWhere(
                  (d) => d.id == entry.key,
                  orElse: () => Detail(id: entry.key, name: 'خدمة غير معروفة'),
                );

                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: CustomCheckBox(
                    title: detail.name ?? '',
                    value: entry.value,
                    onChanged: (value) {
                      if (create) {
                        createProvider.toggleService(entry.key, value);
                      } else {
                        updateProvider.toggleService(entry.key, value);
                      }
                    },
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
