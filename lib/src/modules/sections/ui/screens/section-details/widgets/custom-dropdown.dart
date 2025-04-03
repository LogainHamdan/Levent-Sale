import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomDropdownSection extends StatelessWidget {
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
        List<String> uniqueItems = items.toSet().toList();
        String? selectedValue = provider.getSelectedValue(dropdownKey);

        if (selectedValue != null && !uniqueItems.contains(selectedValue)) {
          selectedValue = null;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: selectedValue,
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: grey8,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset(
                      arrowDownPath,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    offset: Offset(0, 5),
                  ),
                  hint: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      alignment: Alignment.centerRight,
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
            ),
          ],
        );
      },
    );
  }
}
