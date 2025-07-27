import 'package:Levant_Sale/src/modules/auth/ui/screens/login/widgets/checkbox.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/selected-img-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../models/adDTO.dart';
import 'provider.dart';

class SectionDetails2 extends StatefulWidget {
  const SectionDetails2({
    super.key,
  });

  @override
  State<SectionDetails2> createState() => _SectionDetails2State();
}

class _SectionDetails2State extends State<SectionDetails2> {
  late final createProvider;

  void initState() {
    super.initState();
    createProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      createProvider.loadGovernorates();
      if (createProvider.selectedGovernorate != null) {
        createProvider.loadCities(
            governorateId: createProvider.selectedGovernorate?.id ?? 2);
      }
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
                  createProvider.titleController.text = value;
                },
                controller: createProvider.titleController,
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
                createProvider.shortDescController.text = value;
              },
              label: null,
              controller: createProvider.shortDescController,
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
            SizedBox(height: 300.h, child: RichTextEditor()),
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
            ImagePickerColumn(),
            SizedBox(height: 5.h),
            SelectedImagesSection(),
            SizedBox(height: 8.h),

            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, createProvider, _) {
                return Column(
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
                    CustomDropdownSection(
                      errorText: '',
                      hint: 'اختر طريقة التواصل',
                      items: ContactMethod.values
                          .map((e) => e.displayName)
                          .toList(),
                      dropdownKey: 'contactMethod',
                      title: null,
                      onItemSelected: (selectedName) {
                        print('Selected display name: $selectedName');

                        var selectedMethod =
                        ContactMethodExtension.fromDisplayName(
                            selectedName);
                        createProvider.setSelectedContactMethod(selectedMethod);
                        print(
                            'selected: ${createProvider.selectedContactMethod}');
                        createProvider.setSelectedValue(
                            'contactMethod', selectedName);
                      },
                    ),
                    if (createProvider.selectedContactMethod != null) ...[
                      SizedBox(height: 8.h),
                      if (createProvider.numberMethods
                          .contains(createProvider.selectedContactMethod!)) ...[
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
                                  text: 'رقم ${createProvider.selectedContactMethod!.displayName}',
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
                          controller: createProvider.contactDetailController,
                          label: null,
                          onChanged: (value) {
                            createProvider.setSelectedValue(
                                'contactDetail', value);
                          },
                          hint: 'أدخل الرقم',
                          bgcolor: grey8,

                        ),
                      ] else if (createProvider.emailMethods
                          .contains(createProvider.selectedContactMethod!)) ...[

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
                                  text: 'بريد ${createProvider.selectedContactMethod!.displayName}',
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
                          controller: createProvider.contactDetailController,
                          label: null,
                          onChanged: (value) {
                            createProvider.setSelectedValue(
                                'contactDetail', value);
                          },
                          hint: 'أدخل البريد الإلكتروني',
                          bgcolor: grey8,
                        ),
                      ] else if (createProvider.detailMethods
                          .contains(createProvider.selectedContactMethod!)) ...[

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
                                  text: 'تفاصيل ${createProvider.selectedContactMethod!.displayName}',
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
                          controller: createProvider.contactDetailController,
                          label: null,
                          onChanged: (value) {
                            createProvider.setSelectedValue(
                                'contactDetail', value);
                          },
                          hint: 'أدخل التفاصيل',
                          bgcolor: grey8,
                        ),
                      ]
                    ]
                  ],
                );
              },
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
            CustomDropdownSection(
              errorText: '',
              hint: 'اختر نوع الإعلان',
              items: AdType.values.map((e) => e.displayName).toList(),
              dropdownKey: 'adType',
              title: null,
              onItemSelected: (selectedName) {
                createProvider.setSelectedAdType(
                  AdTypeExtension.fromDisplayName(selectedName),
                );
                createProvider.setSelectedValue('adType', selectedName);
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
                  createProvider.priceController.text = value;
                },
                controller: createProvider.priceController,
                hint: '',
                bgcolor: grey8,
                ),
            SizedBox(height: 8.h),

            // نوع العملة
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, child) => Column(
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
                  CustomDropdownSection(
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
                ],
              ),
            ),
            SizedBox(height: 8.h),

            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, child) => CustomCheckBox(
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
            ),
            SizedBox(height: 8.h),

            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, child) => CustomCheckBox(
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
            ),
            SizedBox(height: 8.h),

            // المحافظة
            Consumer<CreateAdSectionDetailsProvider>(
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
                    CustomDropdownSection(
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
                        createProvider.loadCities(
                            governorateId: createProvider.selectedGovernorate.id);
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 8.h),

            // المدينة
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                final isCityEnabled = provider.selectedGovernorate != null;

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
                    CustomDropdownSection(
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