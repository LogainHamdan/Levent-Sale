import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/search-filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.all(10.w),
          child: Image.asset(
            'assets/imgs_icons/home/assets/icons/search.png',
            width: 20.w,
            height: 20.h,
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, FilterScreen.id),
                child: Image.asset(
                  'assets/imgs_icons/home/assets/icons/filter.png',
                  width: 25.w,
                  height: 25.h,
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
        hintStyle: TextStyle(color: grey5),
        hintText: 'بحث',
        filled: true,
        fillColor: grey7,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
