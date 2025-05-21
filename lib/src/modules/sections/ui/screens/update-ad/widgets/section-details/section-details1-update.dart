import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/update-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/checking-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../../config/constants.dart';
import '../../../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../../../models/attriburtes.dart';
import '../../provider.dart';

class SectionDetails1Update extends StatelessWidget {
  const SectionDetails1Update({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateAdProvider>(context, listen: false);

    final detailsProvider =
        Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);
    return FutureBuilder(
      future: () async {
        final lastCategoryId = detailsProvider
            .extractLastCategoryId(provider.selectedAdToUpdate?.categoryPath);
        await detailsProvider.fetchAttributes(lastCategoryId);

        detailsProvider.initializeSelectedValuesFromAd(
            provider.selectedAdToUpdate?.attributes);
      }(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        return Consumer<UpdateAdSectionDetailsProvider>(
          builder: (context, provider, _) {
            final attributesData = provider.attributesData;
            if (attributesData == null || attributesData.attributes == null) {
              return const Center(child: CustomCircularProgressIndicator());
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
                                  controller:
                                      provider.getController(field.name ?? ''),
                                  hint: field.placeholder,
                                  bgcolor: grey8,
                                  errorText: provider
                                          .getController(field.name ?? '')
                                          .text
                                          .isEmpty
                                      ? 'هذا الحقل مطلوب'
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
                                  errorText: provider
                                          .getController(field.name ?? '')
                                          .text
                                          .isEmpty
                                      ? 'هذا الحقل مطلوب'
                                      : '',
                                  label: field.label,
                                  controller:
                                      provider.getController(field.name ?? ''),
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
                                    CustomDropdownSectionUpdate(
                                      title: field.label ?? 'عنوان غير معروف',

                                      dropdownKey: field.name ?? '',
                                      hint: field.placeholder ?? 'اختر',
                                      items: field.options ?? [],
                                      errorText:
                                          "هذا الحقل مطلوب", // Error message
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                ]);
                          case FieldType.radio:
                            final options = field.options ?? ['نعم', 'لا'];
                            final onValue =
                                options.isNotEmpty ? options.first : 'نعم';
                            final offValue =
                                options.length > 1 ? options[1] : 'لا';
                            final currentValue =
                                provider.getSelectedValue(field.name ?? '');

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomSwitchTileUpdate(
                                  title: field.label ?? '',
                                  value: currentValue == onValue,
                                  onChanged: (val) {
                                    final newValue = val ? onValue : offValue;
                                    (provider.setSelectedValue(
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
                                  CheckingContainerUpdate(),
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
      },
    );
  }
}
