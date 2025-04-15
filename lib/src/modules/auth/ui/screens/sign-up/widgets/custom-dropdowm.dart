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
  final ValueChanged<String>? onChanged;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, provider, child) {
        double headerHeight = 50.h;
        double itemHeight = 42.h;
        double expandedHeight = headerHeight +
            (provider.isDropdownOpened ? items.length * itemHeight : 0);

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
                    provider.setDropdownOpened(!provider.isDropdownOpened);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      provider.isDropdownOpened
                          ? Padding(
                              padding: EdgeInsets.only(left: 3.w, top: 2.h),
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
                        (provider.selectedValue != null &&
                                provider.selectedValue!.isNotEmpty)
                            ? provider.selectedValue!
                            : hint,
                        style: GoogleFonts.tajawal(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: (provider.selectedValue != null &&
                                  provider.selectedValue!.isNotEmpty)
                              ? Colors.black
                              : grey4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (provider.isDropdownOpened)
                Column(
                  children: items.map((item) {
                    return InkWell(
                      onTap: () {
                        provider.setDropdownOpened(false);
                        if (onChanged != null) {
                          onChanged!(item);
                        }
                      },
                      child: Container(
                        height: itemHeight,
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(
                          item,
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.tajawal(
                            fontSize: 15.sp,
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
