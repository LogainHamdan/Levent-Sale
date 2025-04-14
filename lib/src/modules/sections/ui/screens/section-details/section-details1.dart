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
import '../create-ad/provider.dart';
import '../update-ad/provider.dart';

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
        // if (create
        //     ? createDetailsProvider.attributesData == null
        //     : updateDetailsProvider.attributesData == null) {
        //   return const Center(child: Text('لا توجد بيانات لعرضها'));
        // }
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: SingleChildScrollView(
                child: (create
                        ? createDetailsProvider.attributesData == null
                        : updateDetailsProvider.attributesData == null)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...(create
                                  ? createDetailsProvider
                                      .attributesData!.attributes.fields
                                  : updateDetailsProvider
                                      .attributesData!.attributes.fields)
                              .map((field) {
                            switch (field.type) {
                              case FieldType.text:
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomTextField(
                                      label: field.label,
                                      controller: TextEditingController(),
                                      hint: field.placeholder ?? '',
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
                                      controller: TextEditingController(),
                                      hint: field.placeholder ?? '',
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
                                    CustomDropdownSection(
                                      title: field.label,
                                      create: true,
                                      dropdownKey: field.name,
                                      hint: field.placeholder ?? 'اختر',
                                      items: field.options ?? [],
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                );
                              case FieldType.checkbox:
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomSwitchTile(
                                      title: field.label,
                                      value: (create
                                              ? createDetailsProvider
                                                  .getSelectedValue(field.name)
                                              : updateDetailsProvider
                                                  .getSelectedValue(
                                                      field.name)) ==
                                          "true",
                                      onChanged: (val) {
                                        (create
                                            ? createDetailsProvider
                                                .setSelectedValue(
                                                    field.name, val.toString())
                                            : updateDetailsProvider
                                                .setSelectedValue(field.name,
                                                    val.toString()));
                                      },
                                      activeColor: kprimaryColor,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                );
                            }
                          }).toList(),
                          if (create
                              ? (createDetailsProvider
                                  .attributesData!.details.isNotEmpty)
                              : (updateDetailsProvider
                                  .attributesData!.details.isNotEmpty))
                            ...(create
                                    ? createDetailsProvider
                                        .attributesData!.details
                                    : updateDetailsProvider
                                        .attributesData!.details)
                                .map((detail) {
                              return CustomSwitchTile(
                                title: detail.name,
                                value: (create
                                    ? createDetailsProvider
                                        .getServiceValue(detail.id)
                                    : updateDetailsProvider
                                        .getServiceValue(detail.id)),
                                onChanged: (val) => (create
                                    ? createDetailsProvider.toggleService(
                                        detail.id, val)
                                    : updateDetailsProvider.toggleService(
                                        detail.id, val)),
                                activeColor: kprimaryColor,
                              );
                            }),
                          SizedBox(height: 24.h),
                          CheckingContainer(create: create),
                          SizedBox(height: 41.h),
                        ],
                      )));
      },
    );
  }
}
