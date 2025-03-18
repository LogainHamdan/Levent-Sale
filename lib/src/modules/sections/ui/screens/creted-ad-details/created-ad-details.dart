import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/creted-ad-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/creted-ad-details/widgets/custom-quill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../home/ui/screens/evaluation/widgets/img-picker.dart';
import '../section-details/widgets/custom-label.dart';

class AdCreatedDetails extends StatelessWidget {
  static const id = '/ad_created';

  const AdCreatedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController shortDescController = TextEditingController();
    final TextEditingController contentController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  controller: titleController,
                  hint: '',
                  label: 'عنوان',
                  bgcolor: grey8),
              SizedBox(height: 10.h),
              CustomTextField(
                label: 'وصف صغير',
                controller: shortDescController,
                hint: '',
                bgcolor: grey8,
                keyboardType: TextInputType.multiline,
                paragraph: true,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'محتوى',
                ),
              ),
              // RichTextEditor(),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'صور',
                ),
              ),
              ImagePickerColumn(),
              SizedBox(height: 10.h),
              CustomTextField(
                  label: 'رقم هاتف للتواصل',
                  controller: TextEditingController(),
                  hint: '',
                  bgcolor: grey8),
              SizedBox(height: 10.h),
              CustomTextField(
                  label: 'السعر',
                  controller: TextEditingController(),
                  hint: '',
                  bgcolor: grey8),
              CustomTextField(
                  suffix: Icon(
                    Icons.percent,
                    color: grey4,
                  ),
                  label: 'خصم بنسبة',
                  controller: TextEditingController(),
                  hint: '',
                  bgcolor: grey8),
              SizedBox(
                height: 10.h,
              ),
              CustomElevatedButton(
                  text: 'متابعة',
                  onPressed: () {},
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                  date: false,
                  notText: true)
            ],
          ),
        ),
      ),
    );
  }
}
