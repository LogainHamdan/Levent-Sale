import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;

  const CustomDropdown({
    Key? key,
    required this.hint,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                value: provider.selectedValue.isNotEmpty
                    ? provider.selectedValue
                    : null,
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: grey7,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                iconStyleData: IconStyleData(
                  icon: Image.asset(
                    'assets/imgs_icons/general/arrow-down.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    color: grey7,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  offset: Offset(0, 5),
                ),
                hint: Text(
                  hint,
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: grey4,
                  ),
                ),
                items: items.map((String item) {
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
                  provider.setSelectedValue(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
