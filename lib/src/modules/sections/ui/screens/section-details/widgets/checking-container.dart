import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/screens/login/widgets/checkbox.dart';
import '../../create-ad/provider.dart';
import '../../update-ad/provider.dart';
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
              children: create
                  ? createProvider.services.keys.map((key) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: CustomCheckBox(
                          title: key,
                          value: createProvider.services[key]!,
                          onChanged: (value) =>
                              createProvider.toggleService(key, value),
                        ),
                      );
                    }).toList()
                  : updateProvider.services.keys.map((key) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: CustomCheckBox(
                          title: key,
                          value: updateProvider.services[key]!,
                          onChanged: (value) =>
                              updateProvider.toggleService(key, value),
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
