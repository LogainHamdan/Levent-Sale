import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

        bool isOpen = provider.isDropdownOpened(dropdownKey);

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 14.w),
                childrenPadding: EdgeInsets.symmetric(horizontal: 14.w),
                onExpansionChanged: (isOpen) {
                  provider.setDropdownOpened(dropdownKey, isOpen);
                },
                trailing: SizedBox(
                  width: 36.w,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: isOpen
                        ? SvgPicture.asset(
                            arrowAbovePath,
                            height: 8.h,
                            width: 8.w,
                          )
                        : SvgPicture.asset(
                            arrowDownPath,
                            height: 22.h,
                            width: 22.w,
                          ),
                  ),
                ),
                title: Text(
                  selectedValue ?? "اختر",
                  style: GoogleFonts.tajawal(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: selectedValue != null ? Colors.black : grey4,
                  ),
                ),
                children: uniqueItems.map((item) {
                  return InkWell(
                    onTap: () {
                      provider.setSelectedValue(dropdownKey, item);
                      provider.setDropdownOpened(dropdownKey, false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Text(
                        item,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.tajawal(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
