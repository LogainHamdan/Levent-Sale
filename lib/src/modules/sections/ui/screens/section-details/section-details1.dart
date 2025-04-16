import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/update-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/checking-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-label.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-switch.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/selected-img-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../models/attriburtes.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../choose-section/update-ad-choose-section.dart';

class SectionDetails1 extends StatelessWidget {
  final bool create;

  const SectionDetails1({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    final createAdProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);
    final updateAdProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context);
    final createDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);
    final updateDetailsProvider =
        Provider.of<UpdateAdSectionDetailsProvider>(context);

    final subcategory = create
        ? createAdProvider.selectedSubcategory
        : updateAdProvider.selectedSubcategory;

    if (subcategory == null) {
      return const Center(child: Text('يرجى اختيار قسم فرعي أولًا'));
    }

    return Consumer2<CreateAdSectionDetailsProvider,
        UpdateAdSectionDetailsProvider>(
      builder: (context, createDetailsProvider, updateDetailsProvider, _) {
        final attributesData = create
            ? createDetailsProvider.attributesData
            : updateDetailsProvider.attributesData;

        if (attributesData == null || attributesData.attributes == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (attributesData.attributes?.fields?.isNotEmpty ?? false)
                  ...(attributesData.attributes?.fields ?? []).map((field) {
                    switch (field.type) {
                      case FieldType.text:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              label: field.label,
                              controller: create
                                  ? createDetailsProvider
                                      .getController(field.name ?? '')
                                  : updateDetailsProvider
                                      .getController(field.name ?? ''),
                              hint: field.placeholder,
                              bgcolor: grey8,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      case FieldType.number:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              label: field.label,
                              controller: create
                                  ? createDetailsProvider
                                      .getController(field.name ?? '')
                                  : updateDetailsProvider
                                      .getController(field.name ?? ''),
                              hint: field.placeholder,
                              keyboardType: TextInputType.number,
                              bgcolor: grey8,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      case FieldType.dropdown:
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if ((field.options ?? []).isNotEmpty) ...[
                                CustomDropdownSection(
                                  title: field.label ?? 'عنوان غير معروف',
                                  create: true,
                                  dropdownKey: field.name ?? '',
                                  hint: field.placeholder ?? 'اختر',
                                  items: field.options ?? [],
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ]);
                      case FieldType.checkbox:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomSwitchTile(
                              title: field.label ?? '',
                              value: (create
                                      ? createDetailsProvider
                                          .getSelectedValue(field.name ?? '')
                                      : updateDetailsProvider.getSelectedValue(
                                          field.name ?? '')) ==
                                  "true",
                              onChanged: (val) {
                                (create
                                    ? createDetailsProvider.setSelectedValue(
                                        field.name ?? '', val.toString())
                                    : updateDetailsProvider.setSelectedValue(
                                        field.name ?? '', val.toString()));
                              },
                              activeColor: kprimaryColor,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      default:
                        return SizedBox.shrink();
                    }
                  }).toList(),
                if (attributesData.details?.isNotEmpty ?? false)
                  ...(attributesData.details ?? []).map((detail) {
                    return CustomSwitchTile(
                      title: detail.name ?? 'خدمة غير معروفة',
                      value: (create
                          ? createDetailsProvider
                              .getServiceValue(detail.id ?? 0)
                          : updateDetailsProvider
                              .getServiceValue(detail.id ?? 0)),
                      onChanged: (val) => (create
                          ? createDetailsProvider.toggleService(
                              detail.id ?? 0, val)
                          : updateDetailsProvider.toggleService(
                              detail.id ?? 0, val)),
                      activeColor: kprimaryColor,
                    );
                  }).toList(),
                SizedBox(height: 24.h),
                CheckingContainer(create: create),
                SizedBox(height: 41.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
