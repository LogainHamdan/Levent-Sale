import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/update-ad-section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../../../config/constants.dart';
import '../create-ad-section-details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom-label.dart';

class CustomDropdownSection extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String dropdownKey;
  final bool create;
  final String title;

  const CustomDropdownSection({
    super.key,
    required this.hint,
    required this.items,
    required this.dropdownKey,
    required this.create,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAdSectionDetailsProvider>(
      builder: (context, createProvider, child) {
        List<String> createUniqueItems = items.toSet().toList();
        String? createSelectedValue =
            createProvider.getSelectedValue(dropdownKey);
        bool createIsOpen = createProvider.isDropdownOpened(dropdownKey);

        double headerHeight = 50.h;
        double itemHeight = 42.h;
        double createExpandedHeight = headerHeight +
            (createIsOpen ? createUniqueItems.length * itemHeight : 0);

        return Consumer<UpdateAdSectionDetailsProvider>(
            builder: (context, updateProvider, child) {
          List<String> updateUniqueItems = items.toSet().toList();
          String? updateSelectedValue =
              updateProvider.getSelectedValue(dropdownKey);
          bool updateIsOpen = updateProvider.isDropdownOpened(dropdownKey);

          double headerHeight = 50.h;
          double itemHeight = 42.h;
          double updateExpandedHeight = headerHeight +
              (updateIsOpen ? updateUniqueItems.length * itemHeight : 0);
          return Column(
            children: [
              CustomLabel(text: title),
              SizedBox(
                height: 16.h,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: create ? createExpandedHeight : updateExpandedHeight,
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
                            create
                                ? createProvider.setDropdownOpened(
                                    dropdownKey, !createIsOpen)
                                : updateProvider.setDropdownOpened(
                                    dropdownKey, !createIsOpen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              create
                                  ? createIsOpen
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 6.w, top: 4.h),
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
                                        )
                                  : updateIsOpen
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: 6.w, top: 4.h),
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
                              create
                                  ? Text(
                                      createSelectedValue ?? hint,
                                      style: GoogleFonts.tajawal(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: createSelectedValue != null
                                            ? Colors.black
                                            : grey4,
                                      ),
                                    )
                                  : Text(
                                      updateSelectedValue ?? hint,
                                      style: GoogleFonts.tajawal(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: updateSelectedValue != null
                                            ? Colors.black
                                            : grey4,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      create
                          ? createIsOpen
                              ? Column(
                                  children: createUniqueItems.map((item) {
                                    return InkWell(
                                      onTap: () {
                                        createProvider.setSelectedValue(
                                            dropdownKey, item);
                                        createProvider.setDropdownOpened(
                                            dropdownKey, false);
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
                                )
                              : SizedBox()
                          : updateIsOpen
                              ? Column(
                                  children: createUniqueItems.map((item) {
                                    return InkWell(
                                      onTap: () {
                                        updateProvider.setSelectedValue(
                                            dropdownKey, item);
                                        updateProvider.setDropdownOpened(
                                            dropdownKey, false);
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
                                )
                              : SizedBox()
                    ]),
              ),
            ],
          );
        });
      },
    );
  }
}
