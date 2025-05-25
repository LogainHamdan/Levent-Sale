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
            CustomTextField(
                errorText: provider.titleController.text.isEmpty
                    ? 'هذا الحقل مطلوب'
                    : '',
                onChanged: (value) {
                  provider.titleController.text = value;
                },
                controller: provider.titleController,
                hint: '',
                label: 'عنوان',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
              errorText: provider.shortDescController.text.isEmpty
                  ? 'هذا الحقل مطلوب'
                  : '',
              onChanged: (value) {
                provider.shortDescController.text = value;
              },
              label: 'وصف صغير',
              controller: provider.shortDescController,
              hint: '',
              bgcolor: grey8,
              paragraphBorderRadius: 10.r,
              paragraph: true,
            ),
            SizedBox(
              height: 16.h,
            ),
            Align(alignment: Alignment.centerRight, child: Text('محتوى')),
            SizedBox(height: 300.h, child: RichTextEditorUpdate()),
            SizedBox(height: 24.h),
            Align(alignment: Alignment.centerRight, child: Text('صور')),
            ImagePickerColumnUpdate(),
            SizedBox(
              height: 10.h,
            ),
            SelectedImagesSectionUpdate(),
            SizedBox(
              height: 16.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomDropdownSectionUpdate(
                  errorText: 'هذا الحقل مطلوب',
                  hint: 'اختر طريقة التواصل',
                  items:
                      ContactMethod.values.map((e) => e.displayName).toList(),
                  dropdownKey: 'contactMethod',
                  title: 'طريقة التواصل',
                  onItemSelected: (selectedName) {
                    var selectedMethod =
                        ContactMethodExtension.fromDisplayName(selectedName);
                    provider.setSelectedContactMethod(selectedMethod);
                    provider.setSelectedValue('contactMethod', selectedName);
                  },
                ),
                if (provider.selectedContactMethod != null) ...[
                  const SizedBox(height: 16),
                  if (provider.numberMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    CustomTextField(
                      errorText: provider.contactDetailController.text.isEmpty
                          ? 'هذا الحقل مطلوب'
                          : '',
                      controller: provider.contactDetailController,
                      label:
                          'رقم ${ContactMethodExtension(provider.selectedContactMethod!).displayName}',
                      onChanged: (value) {
                        provider.setSelectedValue('contactDetail', value);
                      },
                      hint: 'أدخل الرقم',
                      bgcolor: grey8,
                    ),
                  ] else if (provider.emailMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    CustomTextField(
                      errorText: provider.contactDetailController.text.isEmpty
                          ? 'هذا الحقل مطلوب'
                          : '',
                      controller: provider.contactDetailController,
                      label:
                          'بريد ${ContactMethodExtension(provider.selectedContactMethod!).displayName}}',
                      onChanged: (value) {
                        provider.setSelectedValue('contactDetail', value);
                      },
                      hint: 'أدخل البريد الإلكتروني',
                      bgcolor: grey8,
                    ),
                  ] else if (provider.detailMethods
                      .contains(provider.selectedContactMethod!)) ...[
                    CustomTextField(
                      errorText: provider.contactDetailController.text.isEmpty
                          ? 'هذا الحقل مطلوب'
                          : '',
                      controller: provider.contactDetailController,
                      label:
                          'تفاصيل ${ContactMethodExtension(provider.selectedContactMethod!).displayName}',
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
            SizedBox(
              height: 16.h,
            ),
            CustomDropdownSectionUpdate(
              errorText: 'هذا الحقل مطلوب',
              hint: 'اختر نوع الإعلان',
              items: AdType.values.map((e) => e.displayName).toList(),
              dropdownKey: 'adType',
              title: 'نوع الإعلان',
              onItemSelected: (selectedName) {
                provider.setSelectedAdType(
                  AdTypeExtension.fromDisplayName(selectedName),
                );
                provider.setSelectedValue('adType', selectedName);
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                errorText: provider.priceController.text.isEmpty
                    ? 'هذا الحقل مطلوب'
                    : '',
                label: 'السعر',
                onChanged: (value) {
                  provider.priceController.text = value;
                },
                controller: provider.priceController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomDropdownSectionUpdate(
              errorText: 'هذا الحقل مطلوب',
              hint: 'اختر نوع العملة',
              items: Currency.values.map((e) => e.arabicName).toList(),
              dropdownKey: 'currency',
              title: 'نوع العملة',
              onItemSelected: (selectedName) {
                final selectedCurrency =
                    CurrencyExtension.fromArabicName(selectedName);
                if (selectedCurrency != null) {
                  provider.setSelectedCurrency('currency', selectedCurrency);
                }
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            // CustomTextField(
            //     suffix: Icon(Icons.percent, color: grey4),
            //     onChanged: (value) {
            //       widget.create
            //           ? createProvider.discountController.text = value
            //           : updateProvider.discountController.text = value;
            //     },
            //     label: 'خصم بنسبة',
            //     controller: widget.create
            //         ? createProvider.discountController
            //         : updateProvider.discountController,
            //     hint: '',
            //     bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomCheckBox(
              value: provider.negotiable,
              title: Text('قابل للتفاوض'),
              onChanged: (val) {
                setState(() {
                  provider.setNegotiable(val);
                });
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomCheckBox(
              value: provider.tradePossible,
              title: Text('قابل للمقايضة'),
              onChanged: (val) {
                setState(() {
                  provider.setTradePossible(val);
                });
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            Consumer<UpdateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return CustomCircularProgressIndicator();
                }
                return CustomDropdownSectionUpdate(
                  errorText: 'هذا الحقل مطلوب',
                  hint: 'ادخل اسم المحافظة',
                  items: provider.governorates
                      .map((governorate) => governorate.governorateName)
                      .toList(),
                  dropdownKey: 'المحافظة',
                  title: 'المحافظة',
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
                );
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            Consumer<UpdateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                final isCityEnabled = provider.selectedGovernorate != null;
                print('enabled city: $isCityEnabled');
                return CustomDropdownSectionUpdate(
                  errorText: 'هذا الحقل مطلوب',
                  hint: 'ادخل اسم المدينة',
                  items: isCityEnabled
                      ? provider.cities.map((city) => city.cityName).toList()
                      : [],
                  dropdownKey: 'المدينة',
                  title: 'المدينة',
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
