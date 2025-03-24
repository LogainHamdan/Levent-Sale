import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/checking-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/column-img-pick.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-label.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-quill.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';

class SectionDetails extends StatelessWidget {
  final int id;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  SectionDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SectionDetailsProvider>(context);
    final stepperProvider = Provider.of<StepperProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: id == 0
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomLabel(text: "عدد الغرف"),
                      CustomDropdown(
                          hint: "اختر", items: ["1", "2", "3", "4", "5+"]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "عدد الحمامات"),
                      CustomDropdown(
                          hint: "اختر", items: ["1", "2", "3", "4+"]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "حالة العقار"),
                      CustomDropdown(
                          hint: "اختر", items: ["جديد", "جيد", "بحاجة لتجديد"]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "المساحة بالمتر المربع"),
                      TextField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          fillColor: grey8,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "عمر العقار"),
                      CustomDropdown(hint: "اختر", items: [
                        "أقل من 5 سنوات",
                        "5-10 سنوات",
                        "أكثر من 10 سنوات"
                      ]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "الطابق"),
                      CustomDropdown(
                          hint: "اختر", items: ["أرضي", "1", "2", "3", "4+"]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "هل العقار مفروش؟"),
                      CustomDropdown(hint: "اختر", items: ["نعم", "لا"]),
                      SizedBox(height: 10.h),
                      CustomLabel(text: "نوع الملكية"),
                      CustomDropdown(hint: "اختر", items: ["تمليك", "إيجار"]),
                      SizedBox(height: 10.h),
                      Text("هل يحتوي على مصعد؟",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 14.sp)),
                      CustomSwitchTile(
                        value: provider.hasElevator,
                        activeColor: kprimaryColor,
                        onChanged: provider.toggleElevator,
                      ),
                      Text("هل يحتوي على موقف سيارات؟",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 14.sp)),
                      CustomSwitchTile(
                        value: provider.hasParking,
                        onChanged: provider.toggleParking,
                        activeColor: kprimaryColor,
                      ),
                      CheckingContainer(provider: provider),
                      SizedBox(height: 12.h),
                      CustomElevatedButton(
                        text: 'متابعة',
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAdScreen(
                                    lowerWidget: SectionDetails(id: 1)))),
                        backgroundColor: kprimaryColor,
                        textColor: Colors.white,
                        date: false,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
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
                        paragraphBorderRadius: 10,
                        keyboardType: TextInputType.multiline,
                        paragraph: true,
                      ),
                      SizedBox(height: 10.h),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text('محتوى')),
                      SizedBox(height: 300.h, child: RichTextEditor()),
                      SizedBox(height: 10.h),
                      Align(
                          alignment: Alignment.centerRight, child: Text('صور')),
                      ImagePickerColumn(),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          label: 'رقم هاتف للتواصل',
                          controller: phoneController,
                          hint: '',
                          bgcolor: grey8),
                      SizedBox(height: 10.h),
                      CustomTextField(
                          label: 'السعر',
                          controller: priceController,
                          hint: '',
                          bgcolor: grey8),
                      CustomTextField(
                          suffix: Icon(Icons.percent, color: grey4),
                          label: 'خصم بنسبة',
                          controller: discountController,
                          hint: '',
                          bgcolor: grey8),
                      SizedBox(height: 10.h),
                      CustomElevatedButton(
                          text: 'متابعة',
                          onPressed: () {
                            stepperProvider.nextStep();
                            showAdCreated(context);
                          },
                          backgroundColor: kprimaryColor,
                          textColor: Colors.white,
                          date: false),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
