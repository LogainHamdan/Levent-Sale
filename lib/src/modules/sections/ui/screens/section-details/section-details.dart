import 'package:Levant_Sale/src/modules/auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/checking-container.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-label.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/widgets/custom-switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-dropdowm.dart';

class SectionDetails extends StatelessWidget {
  static const id = '/sec_detials';

  const SectionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PropertyFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomLabel(text: "عدد الغرف"),
                CustomDropdown(hint: "اختر", items: ["1", "2", "3", "4", "5+"]),
                SizedBox(height: 10.h),
                CustomLabel(text: "عدد الحمامات"),
                CustomDropdown(hint: "اختر", items: ["1", "2", "3", "4+"]),
                SizedBox(height: 10.h),
                CustomLabel(text: "حالة العقار"),
                CustomDropdown(
                    hint: "اختر", items: ["جديد", "جيد", "بحاجة لتجديد"]),
                SizedBox(height: 10.h),
                CustomLabel(text: "المساحة بالمتر المربع"),
                CustomTextField(
                    controller: TextEditingController(),
                    hint: '',
                    bgcolor: grey8),
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
                Text(
                  "هل يحتوي على مصعد؟",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                CustomSwitchTile(
                  value: provider.hasElevator,
                  activeColor: kprimaryColor,
                  onChanged: provider.toggleElevator,
                ),
                Text(
                  textDirection: TextDirection.rtl,
                  "هل يحتوي على موقف سيارات؟",
                  style: TextStyle(fontSize: 14.sp),
                ),
                CustomSwitchTile(
                  value: provider.hasParking,
                  onChanged: provider.toggleParking,
                  activeColor: kprimaryColor,
                ),
                CheckingContainer(provider: provider),
                CustomElevatedButton(
                  text: 'متابعة',
                  onPressed: () {},
                  backgroundColor: kprimaryColor,
                  textColor: Colors.white,
                  date: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
