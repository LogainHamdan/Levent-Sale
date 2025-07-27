import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/selected-img-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/widgets/selected-img-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/constants.dart';
import '../../../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../../../models/ad.dart';
import '../../../../../models/adDTO.dart';

import '../../../section-details/provider.dart';
import 'provider.dart';

class SectionDetails2Update extends StatefulWidget {
  const SectionDetails2Update({
    super.key,
  });

  @override
  State<SectionDetails2Update> createState() => SectionDetails2UpdateState();
}

class SectionDetails2UpdateState extends State<SectionDetails2Update> {
  late final provider;

  void initState() {
    super.initState();
    provider =
        Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadGovernorates();
      provider.loadCities(governorateId: provider.selectedGovernorate?.id ?? 2);

      provider.initializeControllers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // عنوان
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: 'عنوان',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            CustomTextField(
                errorText: '',
                onChanged: (value) {
                  provider.titleController.text = value;
                },
                controller: provider.titleController,
                hint: '',
                label: null,
                bgcolor: grey8),
            SizedBox(height: 8.h),

            // وصف صغير
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: 'وصف صغير',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            CustomTextField(
              errorText: '',
              onChanged: (value) {
                provider.shortDescController.text = value;
              },
              label: null,
              controller: provider.shortDescController,
              hint: '',
              bgcolor: grey8,
              paragraphBorderRadius: 10.r,
              paragraph: true,
            ),
            SizedBox(height: 8.h),

            // محتوى
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'محتوى',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(height: 300.h, child: RichTextEditorUpdate()),
            SizedBox(height: 12.h),

            // صور
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'صور',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            ImagePickerColumnUpdate(),
            SizedBox(height: 5.h),
            SelectedImagesSectionUpdate(),
            SizedBox(height: 8.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // طريقة التواصل
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontFamily: GoogleFonts.tajawal().fontFamily,
                          ),
                        ),
                        TextSpan(
                          text: 'طريقة التواصل',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontFamily: GoogleFonts.tajawal().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                CustomDropdownSectionUpdate(
                  errorText: '',
                  hint: 'اختر طريقة التواصل',
                  items:
                  ContactMethod.values.map((e) => e.displayName).toList(),
                  dropdownKey: 'contactMethod',
                  title: null,
                  onItemSelected: (selectedName) {
                    var selectedMethod =
                    ContactMethodExtension.fromDisplayName(selectedName);
                    provider.setSelectedContactMethod(selectedMethod);
                    provider.setSelectedValue('contactMethod', selectedName);
                  },
                ),
                if (provider.selectedContactMethod != null) ...[
                  SizedBox(height: 8.h),
                  if (provider.numberMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    // رقم التواصل
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'رقم ${ContactMethodExtension(provider.selectedContactMethod!).displayName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomTextField(
                      errorText: '',
                      controller: provider.contactDetailController,
                      label: null,
                      onChanged: (value) {
                        provider.setSelectedValue('contactDetail', value);
                      },
                      hint: 'أدخل الرقم',
                      bgcolor: grey8,
                      numbersOnly: true,
                    ),
                  ] else if (provider.emailMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    // بريد التواصل
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'بريد ${ContactMethodExtension(provider.selectedContactMethod!).displayName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomTextField(
                      errorText: '',
                      controller: provider.contactDetailController,
                      label: null,
                      onChanged: (value) {
                        provider.setSelectedValue('contactDetail', value);
                      },
                      hint: 'أدخل البريد الإلكتروني',
                      bgcolor: grey8,
                    ),
                  ] else if (provider.detailMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    // تفاصيل التواصل
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'تفاصيل ${ContactMethodExtension(provider.selectedContactMethod!).displayName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomTextField(
                      errorText: '',
                      controller: provider.contactDetailController,
                      label: null,
                      onChanged: (value) {
                        provider.setSelectedValue('contactDetail', value);
                      },
                      hint: 'أدخل التفاصيل',
                      bgcolor: grey8,
                    ),
                  ]
                ]
              ],
            ),
            SizedBox(height: 8.h),

            // نوع الإعلان
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: 'نوع الإعلان',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            CustomDropdownSectionUpdate(
              errorText: '',
              hint: 'اختر نوع الإعلان',
              items: AdType.values.map((e) => e.displayName).toList(),
              dropdownKey: 'adType',
              title: null,
              onItemSelected: (selectedName) {
                provider.setSelectedAdType(
                  AdTypeExtension.fromDisplayName(selectedName),
                );
                provider.setSelectedValue('adType', selectedName);
              },
            ),
            SizedBox(height: 8.h),

            // السعر
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: 'السعر',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            CustomTextField(
                errorText: '',
                label: null,
                onChanged: (value) {
                  provider.priceController.text = value;
                },
                controller: provider.priceController,
                hint: '',
                bgcolor: grey8,
                numbersOnly: true),
            SizedBox(height: 8.h),

            // نوع العملة
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                    TextSpan(
                      text: 'نوع العملة',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h),
            CustomDropdownSectionUpdate(
              errorText: '',
              hint: 'اختر نوع العملة',
              items: Currency.values.map((e) => e.arabicName).toList(),
              dropdownKey: 'currency',
              title: null,
              onItemSelected: (selectedName) {
                final selectedCurrency =
                CurrencyExtension.fromArabicName(selectedName);
                if (selectedCurrency != null) {
                  provider.setSelectedCurrency('currency', selectedCurrency);
                }
              },
            ),
            SizedBox(height: 8.h),

            CustomCheckBox(
              value: provider.negotiable,
              title: Text(
                'قابل للتفاوض',
                style: TextStyle(
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  provider.setNegotiable(val);
                });
              },
            ),
            SizedBox(height: 8.h),

            CustomCheckBox(
              value: provider.tradePossible,
              title: Text(
                'قابل للمقايضة',
                style: TextStyle(
                  fontFamily: GoogleFonts.tajawal().fontFamily,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  provider.setTradePossible(val);
                });
              },
            ),
            SizedBox(height: 8.h),

            // المحافظة
            Consumer<UpdateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return CustomCircularProgressIndicator();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'المحافظة',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdownSectionUpdate(
                      errorText: '',
                      hint: 'ادخل اسم المحافظة',
                      items: provider.governorates
                          .map((governorate) => governorate.governorateName)
                          .toList(),
                      dropdownKey: 'المحافظة',
                      title: null,
                      onItemSelected: (selectedName) {
                        provider.resetCity();
                        provider.setSelectedValue('المدينة', null);
                        final selectedGovernorate =
                        provider.governorates.firstWhere(
                              (gov) => gov.governorateName == selectedName,
                          orElse: () => provider.governorates.first,
                        );
                        provider.setSelectedGovernorate(selectedGovernorate);
                        provider.loadCities(
                            governorateId: provider.selectedGovernorate?.id ?? 0);
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 8.h),

            // المدينة
            Consumer<UpdateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                final isCityEnabled = provider.selectedGovernorate != null;
                print('enabled city: $isCityEnabled');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'المدينة',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontFamily: GoogleFonts.tajawal().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    CustomDropdownSectionUpdate(
                      errorText: '',
                      hint: 'ادخل اسم المدينة',
                      items: isCityEnabled
                          ? provider.cities.map((city) => city.cityName).toList()
                          : [],
                      dropdownKey: 'المدينة',
                      title: null,
                      onItemSelected: isCityEnabled
                          ? (selectedName) {
                        final selectedCity = provider.cities.firstWhere(
                              (city) => city.cityName == selectedName,
                          orElse: () => provider.cities.first,
                        );
                        provider.setSelectedCity(selectedCity);
                      }
                          : null,
                      enabled: isCityEnabled,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}