import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/search-filter.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final bool? hasFilterIcon;
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    this.hasFilterIcon = true,
    this.width = 223,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width!.w,
      height: 44.h,
      child: TextField(
        controller: controller,
        style: GoogleFonts.tajawal(
            textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp)),
        textAlign: TextAlign.right,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.all(10.w),
            child: InkWell(
                onTap: () {
                  final text = controller.text.trim();
                  print("Search icon tapped");
                  if (text.isNotEmpty) {
                    if (onChanged != null) {
                      onChanged!(text);
                    }
                    // ✅ اختياري: التنقل إلى صفحة نتائج البحث دائمًا
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            SearchScreen(), // أو SearchScreen(users: true)
                      ),
                    );
                  } else {
                    Navigator.pushNamed(context, SearchScreen.id);
                  }
                },
                child: Image.asset(searchIcon, height: 24.h, width: 24.w)),
          ),
          prefixIcon: hasFilterIcon!
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, FilterScreen.id),
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
                )
              : SizedBox(),
          hintStyle: GoogleFonts.tajawal(
              textStyle: TextStyle(
                  color: grey5, fontWeight: FontWeight.w500, fontSize: 16.sp)),
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
