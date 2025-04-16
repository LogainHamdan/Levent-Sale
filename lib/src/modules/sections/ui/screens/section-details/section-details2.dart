import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/selected-img-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'create-ad-section-details.dart';

class SectionDetails2 extends StatelessWidget {
  final bool create;

  const SectionDetails2({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    final createDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);
    final updateDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
                controller: create
                    ? createDetailsProvider.titleController
                    : updateDetailsProvider.titleController,
                hint: '',
                label: 'عنوان',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
              label: 'وصف صغير',
              controller: create
                  ? createDetailsProvider.shortDescController
                  : updateDetailsProvider.shortDescController,
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
                  create: create,
                )),
            SizedBox(height: 24.h),
            Align(alignment: Alignment.centerRight, child: Text('صور')),
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
                controller: create
                    ? createDetailsProvider.phoneController
                    : updateDetailsProvider.phoneController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                label: 'السعر',
                controller: create
                    ? createDetailsProvider.priceController
                    : updateDetailsProvider.priceController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
            CustomTextField(
                suffix: Icon(Icons.percent, color: grey4),
                label: 'خصم بنسبة',
                controller: create
                    ? createDetailsProvider.discountController
                    : updateDetailsProvider.discountController,
                hint: '',
                bgcolor: grey8),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
