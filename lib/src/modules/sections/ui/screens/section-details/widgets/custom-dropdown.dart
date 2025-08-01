import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'custom-label.dart';

import 'custom-label.dart';

class CustomDropdownSection extends StatelessWidget {
  final String hint;
  final List<dynamic> items;
  final String dropdownKey;
  final String? title;
  final Function(String selectedItem)? onItemSelected;
  final bool enabled;
  final String? errorText;

  const CustomDropdownSection({
    super.key,
    required this.hint,
    required this.items,
    required this.dropdownKey,
    this.onItemSelected,
    this.title = '',
    this.enabled = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateAdSectionDetailsProvider>(
      builder: (context, createProvider, child) {
        List<dynamic> createUniqueItems = items.toSet().toList();

        String? createSelectedValue =
            createProvider.getSelectedValue(dropdownKey);
        bool createIsOpen = createProvider.isDropdownOpened(dropdownKey);

        bool isOpen = createIsOpen;
        List<dynamic> shownItems = createUniqueItems;
        String? selectedValue = createSelectedValue;
        final bool showError =
            (selectedValue == null || selectedValue.isEmpty) &&
                (errorText != null && errorText!.isNotEmpty);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (title != null) CustomLabel(text: title!),
            SizedBox(height: 4.h),
            Container(
              decoration: BoxDecoration(
                color: enabled ? grey8 : grey8.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                    child: InkWell(
                      onTap: enabled
                          ? () {
                              createProvider.setDropdownOpened(
                                  dropdownKey, !isOpen);
                            }
                          : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isOpen
                              ? Padding(
                                  padding: EdgeInsets.only(left: 6.w, top: 4.h),
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
                              color: enabled
                                  ? (selectedValue != null
                                      ? Colors.black
                                      : grey4)
                                  : grey4.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: isOpen && enabled
                        ? Column(
                            children: shownItems.map((item) {
                              return InkWell(
                                onTap: () {
                                  createProvider.setSelectedValue(
                                      dropdownKey, item);
                                  createProvider.setDropdownOpened(
                                      dropdownKey, false);

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
                                    maxLines: 1,
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
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            if (showError)
              Padding(
                padding: EdgeInsets.only(top: 4.h, right: 8.w),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    errorText!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: errorColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
