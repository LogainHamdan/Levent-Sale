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
  final List<String?> items;
  final String dropdownKey;
  final bool create;
  final String? title;
  final Function(String selectedItem)? onItemSelected;

  const CustomDropdownSection({
    super.key,
    required this.hint,
    required this.items,
    required this.dropdownKey,
    required this.create,
    this.onItemSelected,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAdSectionDetailsProvider>(
      builder: (context, createProvider, child) {
        List<String?> createUniqueItems = items.toSet().toList();
        String? createSelectedValue =
            createProvider.getSelectedValue(dropdownKey);
        bool createIsOpen = createProvider.isDropdownOpened(dropdownKey);

        return Consumer<UpdateAdSectionDetailsProvider>(
          builder: (context, updateProvider, child) {
            List<String?> updateUniqueItems = items.toSet().toList();
            String? updateSelectedValue =
                updateProvider.getSelectedValue(dropdownKey);
            bool updateIsOpen = updateProvider.isDropdownOpened(dropdownKey);

            bool isOpen = create ? createIsOpen : updateIsOpen;
            List<String?> shownItems =
                create ? createUniqueItems : updateUniqueItems;
            String? selectedValue =
                create ? createSelectedValue : updateSelectedValue;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (title != null) CustomLabel(text: title!),
                SizedBox(height: 4.h),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    decoration: BoxDecoration(
                      color: grey8,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: InkWell(
                            onTap: () {
                              if (create) {
                                createProvider.setDropdownOpened(
                                    dropdownKey, !isOpen);
                              } else {
                                updateProvider.setDropdownOpened(
                                    dropdownKey, !isOpen);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isOpen
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
                                Text(
                                  selectedValue ?? hint,
                                  style: GoogleFonts.tajawal(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: selectedValue != null
                                        ? Colors.black
                                        : grey4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isOpen)
                          Column(
                            children: shownItems.map((item) {
                              return InkWell(
                                onTap: () {
                                  if (create) {
                                    createProvider.setSelectedValue(
                                        dropdownKey, item);
                                    createProvider.setDropdownOpened(
                                        dropdownKey, false);
                                  } else {
                                    updateProvider.setSelectedValue(
                                        dropdownKey, item);
                                    updateProvider.setDropdownOpened(
                                        dropdownKey, false);
                                  }
                                  if (onItemSelected != null) {
                                    onItemSelected!(item ?? '');
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    item ?? '',
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
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
