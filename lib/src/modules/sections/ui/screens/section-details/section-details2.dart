import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/update-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/selected-img-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';
import '../../../models/adDTO.dart';
import 'create-ad-section-details.dart';

class SectionDetails2 extends StatefulWidget {
  final bool create;

  const SectionDetails2({super.key, required this.create});

  @override
  State<SectionDetails2> createState() => _SectionDetails2State();
}

class _SectionDetails2State extends State<SectionDetails2> {
  late final createProvider;
  late final updateProvider;

  void initState() {
    super.initState();
    createProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context, listen: false);
    updateProvider =
        Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.create) {
        createProvider.loadGovernorates();
        createProvider.loadCities(
            governorateId: createProvider.selectedGovernorate.id ?? 2);
      } else {
        updateProvider.loadGovernorates();
        updateProvider.loadCities();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                isRequired: true,
                onChanged: (value) {
                  widget.create
                      ? createProvider.titleController.text = value
                      : updateProvider.titleController.text = value;
                },
                controller: widget.create
                    ? createProvider.titleController
                    : updateProvider.titleController,
                hint: '',
                label: 'عنوان',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
              isRequired: true,
              onChanged: (value) {
                widget.create
                    ? createProvider.shortDescController.text = value
                    : updateProvider.shortDescController.text = value;
              },
              label: 'وصف صغير',
              controller: widget.create
                  ? createProvider.shortDescController
                  : updateProvider.shortDescController,
              hint: '',
              bgcolor: grey8,
              paragraphBorderRadius: 10,
              keyboardType: TextInputType.multiline,
              paragraph: true,
            ),
            SizedBox(
              height: 16.h,
            ),
            Align(alignment: Alignment.centerRight, child: Text('محتوى')),
            SizedBox(
                height: 300.h,
                child: RichTextEditor(
                  create: widget.create,
                )),
            SizedBox(height: 24.h),
            Align(alignment: Alignment.centerRight, child: Text('صور')),
            ImagePickerColumn(
              create: widget.create,
            ),
            SizedBox(
              height: 10.h,
            ),
            SelectedImagesSection(
              create: widget.create,
            ),
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, createProvider, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdownSection(
                      hint: 'اختر طريقة التواصل',
                      items: ContactMethod.values
                          .map((e) => e.displayName)
                          .toList(),
                      dropdownKey: 'contactMethod',
                      create: true,
                      title: 'طريقة التواصل',
                      onItemSelected: (selectedName) {
                        createProvider.selectedContactMethod =
                            ContactMethodExtension.fromDisplayName(
                                selectedName);
                        createProvider.setSelectedValue(
                            'contactMethod', selectedName);
                      },
                    ),
                    if (createProvider.selectedContactMethod != null) ...[
                      const SizedBox(height: 16),
                      CustomTextField(
                        isRequired: true,
                        controller: createProvider.contactDetailController,
                        label:
                            '${createProvider.selectedContactMethod!.displayName} تفاصيل',
                        onChanged: (value) {
                          createProvider.setSelectedValue(
                              'contactDetail', value);
                        },
                        hint: '',
                        bgcolor: grey8,
                      ),
                    ]
                  ],
                );
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                isRequired: true,
                label: 'السعر',
                onChanged: (value) {
                  widget.create
                      ? createProvider.priceController.text = value
                      : updateProvider.priceController.text = value;
                },
                controller: widget.create
                    ? createProvider.priceController
                    : updateProvider.priceController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, child) => CustomDropdownSection(
                hint: 'اختر نوع العملة',
                items: Currency.values.map((e) => e.arabicName).toList(),
                dropdownKey: 'العملة',
                create: widget.create,
                title: 'نوع العملة',
                onItemSelected: (selectedName) {
                  final selectedCurrency =
                      CurrencyExtension.fromArabicName(selectedName);
                  if (selectedCurrency != null) {
                    provider.setSelectedCurrency('currency', selectedCurrency);
                  }
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                isRequired: true,
                suffix: Icon(Icons.percent, color: grey4),
                onChanged: (value) {
                  widget.create
                      ? createProvider.discountController.text = value
                      : updateProvider.discountController.text = value;
                },
                label: 'خصم بنسبة',
                controller: widget.create
                    ? createProvider.discountController
                    : updateProvider.discountController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return CustomCircularProgressIndicator();
                }
                return CustomDropdownSection(
                  hint: 'ادخل اسم المحافظة',
                  items: provider.governorates
                      .map((governorate) => governorate.governorateName)
                      .toList(),
                  dropdownKey: 'المحافظة',
                  create: widget.create,
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
                    createProvider.loadCities(
                        governorateId: createProvider.selectedGovernorate.id);
                  },
                );
              },
            ),
            SizedBox(
              height: 16.h,
            ),
            Consumer<CreateAdSectionDetailsProvider>(
              builder: (context, provider, _) {
                final isCityEnabled = provider.selectedGovernorate != null;

                return CustomDropdownSection(
                  hint: 'ادخل اسم المدينة',
                  items: isCityEnabled
                      ? provider.cities.map((city) => city.cityName).toList()
                      : [],
                  dropdownKey: 'المدينة',
                  create: widget.create,
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
