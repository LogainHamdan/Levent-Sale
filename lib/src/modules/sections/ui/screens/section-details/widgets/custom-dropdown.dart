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
        bool isOpen = provider.isDropdownOpened(dropdownKey);

        double headerHeight = 50.h;
        double itemHeight = 42.h;
        double expandedHeight =
            headerHeight + (isOpen ? uniqueItems.length * itemHeight : 0);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: expandedHeight,
          decoration: BoxDecoration(
            color: grey8,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: headerHeight,
                child: InkWell(
                  onTap: () {
                    provider.setDropdownOpened(dropdownKey, !isOpen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isOpen
                          ? Padding(
                              padding: EdgeInsets.only(left: 6.w, top: 4.h),
                              child: SvgPicture.asset(
                                arrowAbovePath,
                                height: 8.h,
                                width: 8.w,
                              ),
                            )
                          : SvgPicture.asset(
                              arrowDownPath,
                              height: 22.h,
                              width: 22.w,
                            ),
                      Text(
                        selectedValue ?? hint,
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: selectedValue != null ? Colors.black : grey4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isOpen)
                Column(
                  children: uniqueItems.map((item) {
                    return InkWell(
                      onTap: () {
                        provider.setSelectedValue(dropdownKey, item);
                        provider.setDropdownOpened(dropdownKey, false);
                      },
                      child: Container(
                        height: itemHeight,
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(
                          item,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.tajawal(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        );
      },
    );
  }
}
