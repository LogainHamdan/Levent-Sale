import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/ui/screens/collection/widgets/empty-widget.dart';
import '../../../../models/address.dart';
import '../provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class SearchResultsWidget extends StatelessWidget {
  final SearchProvider provider;

  const SearchResultsWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, provider, child) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: provider.results.length,
        itemBuilder: (context, index) {
          String query = provider.searchController.text.trim();
          User result = provider.results[index];

          String userName = result.username ?? '';

          if (query.isNotEmpty &&
              userName.toLowerCase().contains(query.toLowerCase())) {
            int startIndex =
                userName.toLowerCase().indexOf(query.toLowerCase());
            int endIndex = startIndex + query.length;

            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: userName.substring(0, startIndex),
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: userName.substring(startIndex, endIndex),
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: userName.substring(endIndex),
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
                    userName, // Display username
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
