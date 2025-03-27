import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomDropdownSection extends StatelessWidget {
  //بدي اعملها نفس الويدجت الي بصفحة انشاء الحساب بس مش عارفة كيف امرر البروفايدر
  final String hint;
  final List<String> items;
  final String dropdownKey;

  const CustomDropdownSection({
    super.key,
    required this.hint,
    required this.items,
    required this.dropdownKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SectionDetailsProvider>(
      builder: (context, provider, child) {
        List<String> uniqueItems = items.toSet().toList(); // إزالة التكرارات
        String? selectedValue = provider.getSelectedValue(dropdownKey);

        // إذا لم تكن القيمة المختارة موجودة في القائمة، نجعلها `null`
        if (selectedValue != null && !uniqueItems.contains(selectedValue)) {
          selectedValue = null;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                value: selectedValue,
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: grey7,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                iconStyleData: IconStyleData(icon: Container()),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: grey6,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  offset: Offset(0, 5),
                ),
                hint: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/imgs_icons/general/arrow-down.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                    Text(
                      hint,
                      style: GoogleFonts.tajawal(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: grey4,
                      ),
                    ),
                  ],
                ),
                items: uniqueItems.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        item,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  provider.setSelectedValue(dropdownKey, value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
