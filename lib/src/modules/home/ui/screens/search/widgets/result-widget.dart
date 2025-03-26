import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/ui/screens/collection/widgets/empty-widget.dart';
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
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // تجنب التمرير المتداخل
          itemCount: provider.searchResults.length,
          itemBuilder: (context, index) {
            String query = provider.searchController.text.trim();
            String result = provider.searchResults[index];

            if (query.isNotEmpty &&
                result.toLowerCase().contains(query.toLowerCase())) {
              int startIndex =
                  result.toLowerCase().indexOf(query.toLowerCase());
              int endIndex = startIndex + query.length;

              return ListTile(
                leading: Image.asset(
                  'assets/imgs_icons/home/assets/icons/search.png',
                  height: 20.h,
                ),
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: result.substring(0, startIndex),
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: result.substring(startIndex, endIndex),
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: result.substring(endIndex),
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListTile(
                leading: Image.asset(
                  'assets/imgs_icons/home/assets/icons/search.png',
                  height: 20.h,
                ),
                title: Text(
                  result,
                  style: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }
          },
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey[300]),
        );
      },
    );
  }
}
