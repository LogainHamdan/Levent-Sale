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

  @override
  void initState() {
    super.initState();
    createProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context, listen: false);
    updateProvider =
        Provider.of<UpdateAdSectionDetailsProvider>(context, listen: false);
    Future.microtask(() => createProvider.loadCities());
    Future.microtask(() => updateProvider.loadCities());
    Future.microtask(() => createProvider.loadGovernorates());
    Future.microtask(() => updateProvider.loadGovernorates());
  }

  @override
  Widget build(BuildContext context) {
    final List<String?> cityNames = (widget.create
            ? createProvider.cities.map((city) => city.cityName)
            : updateProvider.cities.map((city) => city.cityName))
        .cast<String?>()
        .toList();
    final List<String?> governorates = (widget.create
            ? createProvider.governorates
                .map((governorate) => governorate.governorateName)
            : updateProvider.governorates
                .map((governorate) => governorate.governorateName))
        .cast<String?>()
        .toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
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
            CustomTextField(
                label: 'رقم هاتف للتواصل',
                controller: widget.create
                    ? createProvider.phoneController
                    : updateProvider.phoneController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                label: 'السعر',
                controller: widget.create
                    ? createProvider.priceController
                    : updateProvider.priceController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                suffix: Icon(Icons.percent, color: grey4),
                label: 'خصم بنسبة',
                controller: widget.create
                    ? createProvider.discountController
                    : updateProvider.discountController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomDropdownSection(
                hint: 'ادخل اسم المدينة',
                items: cityNames,
                dropdownKey: 'المدينة',
                create: widget.create,
                title: 'المدينة'),
            SizedBox(
              height: 16.h,
            ),
            CustomDropdownSection(
                hint: 'ادخل اسم المحافظة',
                items: governorates,
                dropdownKey: 'المحافظة',
                create: widget.create,
                title: 'المحافظة'),
          ],
        ),
      ),
    );
  }
}
