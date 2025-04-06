import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
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
            InkWell(
              onTap: () {
                provider.setDropdownOpened(!provider.isDropdownOpened);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: grey8,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      provider.isDropdownOpened
                          ? arrowAbovePath
                          : arrowDownPath,
                      height: provider.isDropdownOpened ? 8.h : 22.h,
                      width: provider.isDropdownOpened ? 8.w : 22.w,
                    ),
                    Text(
                      provider.selectedValue.isNotEmpty
                          ? provider.selectedValue
                          : hint,
                      style: GoogleFonts.tajawal(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: provider.selectedValue.isNotEmpty
                            ? Colors.black
                            : grey4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: provider.isDropdownOpened,
              maintainSize: false,
              maintainAnimation: false,
              maintainState: false,
              child: Column(
                children: items.map((item) {
                  return InkWell(
                    onTap: () {
                      provider.setSelectedValue(item);
                      provider.setDropdownOpened(false);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 12.w,
                      ),
                      child: Text(
                        item,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
