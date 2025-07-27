import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../sign-up/provider.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Widget title;
  final String? errorText;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            title == "" ? SizedBox() : title,
            SizedBox(width: title == "" ? 0 : 2),
            Checkbox(
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: value,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
              fillColor: WidgetStateProperty.resolveWith((states) {
                return value ? kprimaryColor : Colors.white;
              }),
              checkColor: Colors.white,
              activeColor: kprimaryColor,
              focusColor: kprimaryColor,
            ),
          ],
        ),
        if (errorText != null && provider.hasTriedSubmit)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                errorText!,
                style: TextStyle(color: Color(0xffF75555), fontSize: 12.sp),
              ),
            ),
          ),
      ],
    );
  }
}
