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

class SectionDetails extends StatelessWidget {
  final bool create;
  final int id;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  SectionDetails({super.key, required this.id, required this.create});

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAdSectionDetailsProvider>(context);
    final updateProvider = Provider.of<UpdateAdSectionDetailsProvider>(context);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SingleChildScrollView(
            child: id == 0
                ? createProvider.attributesData == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...createProvider.attributesData!.attributes.fields
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
                                      value: createProvider
                                              .getSelectedValue(field.name) ==
                                          "true",
                                      onChanged: (val) {
                                        createProvider.setSelectedValue(
                                            field.name, val.toString());
                                      },
                                      activeColor: kprimaryColor,
                                    ),
                                    SizedBox(height: 16.h),
                                  ],
                                );
                            }
                          }).toList(),
                          if (createProvider.attributesData!.details.isNotEmpty)
                            ...createProvider.attributesData!.details
                                .map((detail) {
                              return CustomSwitchTile(
                                title: detail.name,
                                value:
                                    createProvider.getServiceValue(detail.id),
                                onChanged: (val) => createProvider
                                    .toggleService(detail.id, val),
                                activeColor: kprimaryColor,
                              );
                            }),
                          SizedBox(height: 24.h),
                          CheckingContainer(create: create),
                          SizedBox(height: 41.h),
                        ],
                      )
                //  Column(
                //     crossAxisAlignment: CrossAxisAlignment.end,
                //     children: [
                //       CustomDropdownSection(
                //         title: "عدد الغرف",
                //         create: create,
                //         dropdownKey: "عدد الغرف",
                //         hint: "اختر",
                //         items: ["1", "2", "3", "4", "5+"],
                //       ),
                //       SizedBox(height: 24.h),
                //
                //       CustomDropdownSection(
                //         title: "عدد الحمامات",
                //         create: create,
                //         dropdownKey: "عدد الحمامات",
                //         hint: "اختر",
                //         items: ["1", "2", "3", "4+"],
                //       ),
                //       SizedBox(height: 24.h),
                //
                //       CustomDropdownSection(
                //           title: "حالة العقار",
                //           create: create,
                //           dropdownKey: "حالة العقار",
                //           hint: "اختر",
                //           items: [
                //             'مستخدم',
                //             'جديد',
                //           ]),
                //       SizedBox(height: 24.h),
                //       CustomTextField(
                //           label: "المساحة بالمتر المربع",
                //           controller: TextEditingController(),
                //           bgcolor: grey8),
                //       // TextField(
                //       //   controller: TextEditingController(),
                //       //   decoration: InputDecoration(
                //       //     fillColor: grey8,
                //       //     filled: true,
                //       //     border: OutlineInputBorder(
                //       //       borderRadius: BorderRadius.circular(10.r),
                //       //       borderSide: BorderSide.none,
                //       //     ),
                //       //     enabledBorder: OutlineInputBorder(
                //       //       borderRadius: BorderRadius.circular(10.r),
                //       //       borderSide: BorderSide.none,
                //       //     ),
                //       //     focusedBorder: OutlineInputBorder(
                //       //       borderRadius: BorderRadius.circular(10.r),
                //       //       borderSide: BorderSide.none,
                //       //     ),
                //       //   ),
                //       // ),
                //       SizedBox(
                //         height: 16.h,
                //       ),
                //
                //       CustomDropdownSection(
                //           title: "عمر العقار",
                //           create: create,
                //           dropdownKey: "عمر العقار",
                //           hint: "اختر",
                //           items: [
                //             "أقل من 5 سنوات",
                //             "5-10 سنوات",
                //             "أكثر من 10 سنوات"
                //           ]),
                //       SizedBox(
                //         height: 16.h,
                //       ),
                //
                //       CustomDropdownSection(
                //           title: "الطابق",
                //           create: create,
                //           dropdownKey: "الطابق",
                //           hint: "اختر",
                //           items: ["أرضي", "1", "2", "3", "4+"]),
                //       SizedBox(height: 24.h),
                //
                //       CustomDropdownSection(
                //           title: "هل العقار مفروش؟",
                //           create: create,
                //           dropdownKey: "مفروش",
                //           hint: "اختر",
                //           items: ["نعم", "لا"]),
                //       SizedBox(
                //         height: 16.h,
                //       ),
                //
                //       CustomDropdownSection(
                //           title: "نوع الملكية",
                //           create: create,
                //           dropdownKey: "نوع الملكية",
                //           hint: "اختر",
                //           items: ["تمليك", "إيجار"]),
                //       SizedBox(
                //         height: 16.h,
                //       ),
                //
                //       CustomSwitchTile(
                //         title: "هل يحتوي على مصعد؟",
                //         value: create
                //             ? createProvider.hasElevator
                //             : updateProvider.hasElevator,
                //         activeColor: kprimaryColor,
                //         onChanged: create
                //             ? createProvider.toggleElevator
                //             : updateProvider.toggleElevator,
                //       ),
                //
                //       CustomSwitchTile(
                //         title: "هل يحتوي على موقف سيارات؟",
                //         value: create
                //             ? createProvider.hasParking
                //             : updateProvider.hasParking,
                //         onChanged: create
                //             ? createProvider.toggleParking
                //             : updateProvider.toggleParking,
                //         activeColor: kprimaryColor,
                //       ),
                //       SizedBox(
                //         height: 16.h,
                //       ),
                //       create
                //           ? CheckingContainer(
                //               create: true,
                //             )
                //           : CheckingContainer(
                //               create: false,
                //             ),
                //       SizedBox(height: 41.h),
                //     ],
                //   )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                          controller: titleController,
                          hint: '',
                          label: 'عنوان',
                          bgcolor: grey8),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        label: 'وصف صغير',
                        controller: shortDescController,
                        hint: '',
                        bgcolor: grey8,
                        paragraphBorderRadius: 10,
                        keyboardType: TextInputType.multiline,
                        paragraph: true,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text('محتوى')),
                      SizedBox(
                          height: 300.h,
                          child: RichTextEditor(
                            create: create,
                          )),
                      SizedBox(height: 24.h),
                      Align(
                          alignment: Alignment.centerRight, child: Text('صور')),
                      ImagePickerColumn(
                        create: create,
                      ),
                      SelectedImagesSection(
                        create: create,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                          label: 'رقم هاتف للتواصل',
                          controller: phoneController,
                          hint: '',
                          bgcolor: grey8),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                          label: 'السعر',
                          controller: priceController,
                          hint: '',
                          bgcolor: grey8),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                          suffix: Icon(Icons.percent, color: grey4),
                          label: 'خصم بنسبة',
                          controller: discountController,
                          hint: '',
                          bgcolor: grey8),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  )));
  }
}
