import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/create-ad-section-details.dart';
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
import '../../../models/ad.dart';
import '../../../models/attriburtes.dart';
import '../choose-section/create-ad-choose-section-provider.dart';

class SectionDetails1 extends StatelessWidget {
  const SectionDetails1({super.key});

  @override
  Widget build(BuildContext context) {
    final createAdProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);

    final subcategory = createAdProvider.selectedSubcategory;

    if (subcategory == null) {
      return const Center(child: Text('يرجى اختيار قسم فرعي أولًا'));
    }

    return Consumer<CreateAdSectionDetailsProvider>(
      builder: (context, createDetailsProvider, _) {
        final attributesData = createDetailsProvider.attributesData;

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
                  ...(attributesData.attributes?.fields ?? [])
                      .where((field) => field.type != null)
                      .map((field) {
                    if (field.type == null) {
                      return const SizedBox.shrink();
                    }
                    switch (field.type) {
                      case FieldType.text:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              label: field.label,
                              controller: createDetailsProvider
                                  .getController(field.name ?? ''),
                              hint: field.placeholder,
                              bgcolor: grey8,
                              errorText: createDetailsProvider
                                      .getController(field.name ?? '')
                                      .text
                                      .isEmpty
                                  ? 'مطلوب'
                                  : '',
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );
                      case FieldType.number:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              errorText: createDetailsProvider
                                      .getController(field.name ?? '')
                                      .text
                                      .isEmpty
                                  ? 'مطلوب'
                                  : '',
                              label: field.label,
                              controller: createDetailsProvider
                                  .getController(field.name ?? ''),
                              hint: field.placeholder,
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

                                  dropdownKey: field.name ?? '',
                                  hint: field.placeholder ?? 'اختر',
                                  items: field.options ?? [],
                                  errorText: "مطلوب", // Error message
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ]);
                      case FieldType.radio:
                        final options = field.options ?? ['نعم', 'لا'];
                        final onValue =
                            options.isNotEmpty ? options.first : 'نعم';
                        final offValue = options.length > 1 ? options[1] : 'لا';
                        final currentValue = createDetailsProvider
                            .getSelectedValue(field.name ?? '');

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomSwitchTile(
                              title: field.label ?? '',
                              value: currentValue == onValue,
                              onChanged: (val) {
                                final newValue = val ? onValue : offValue;
                                (createDetailsProvider.setSelectedValue(
                                    field.name ?? '', newValue));
                              },
                              activeColor: kprimaryColor,
                            ),
                            SizedBox(height: 16.h),
                          ],
                        );

                      case FieldType.checkbox:
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CheckingContainer(),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        );
                      default:
                        return SizedBox.shrink();
                    }
                  }).toList(),
                SizedBox(height: 41.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
