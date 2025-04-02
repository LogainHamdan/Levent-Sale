import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/search-filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  const SearchField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 223.w,
      height: 48.h,
      child: TextField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon: Padding(
              padding: EdgeInsets.all(10.w),
              child: Image.asset(searchIcon, height: 24.h, width: 24.w)),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, FilterScreen.id),
                  child: SvgPicture.asset(
                    filterIcon,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 5.w),
                Container(
                  height: 20.h,
                  width: 1.5.w,
                  color: grey5,
                ),
              ],
            ),
          ),
          hintStyle: GoogleFonts.tajawal(textStyle: TextStyle(color: grey5)),
          hintText: 'بحث',
          filled: true,
          fillColor: grey8,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
