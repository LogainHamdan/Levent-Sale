import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../provider.dart';

class SearchAdsWidget extends StatelessWidget {
  const SearchAdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, provider, child) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.ads.length,
        itemBuilder: (context, index) {
          final query = provider.searchController.text.trim();
          final ad = provider.ads[index];
          final title = (ad['title'] ?? '').toString();

          if (query.isNotEmpty &&
              title.toLowerCase().contains(query.toLowerCase())) {
            final startIndex = title.toLowerCase().indexOf(query.toLowerCase());
            final endIndex = startIndex + query.length;

            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: title.substring(0, startIndex),
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: title.substring(startIndex, endIndex),
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: title.substring(endIndex),
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(width: 11.w),
                  Image.asset(
                    searchIcon,
                    height: 24.h,
                    width: 24.w,
                  ),
                ],
              ),
            );
          } else {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.tajawal(
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: grey5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(width: 11.w),
                  Image.asset(
                    searchIcon,
                    height: 24.h,
                    width: 24.w,
                  ),
                ],
              ),
            );
          }
        },
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 2.h),
          child: Divider(color: greySplash),
        ),
      );
    });
  }
}
