import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: provider.selectedValue.isNotEmpty
                      ? provider.selectedValue
                      : null,
                  buttonStyleData: ButtonStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: grey8,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  iconStyleData: IconStyleData(icon: Container()),
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
                      SvgPicture.asset(
                        arrowDownPath,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return items.map((String item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.selectedValue.isNotEmpty
                                ? provider.selectedValue
                                : hint,
                            style: GoogleFonts.tajawal(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: provider.selectedValue.isNotEmpty
                                  ? Colors.black
                                  : grey4,
                            ),
                          ),
                          SvgPicture.asset(
                            arrowDownPath,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ],
                      );
                    }).toList();
                  },
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              textDirection: TextDirection.rtl,
                              item,
                              style: GoogleFonts.tajawal(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    provider.setSelectedValue(value);
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
