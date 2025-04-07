import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleRow extends StatelessWidget {
  final Widget? suffix;
  final Function()? onSuffixTap;
  final Function()? additionalBackFunction;

  final String title;
  const TitleRow({
    super.key,
    required this.title,
    this.suffix,
    this.onSuffixTap,
    this.additionalBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        suffix == null
            ? SizedBox(
                width: 35.w,
              )
            : Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: InkWell(
                  onTap: onSuffixTap!,
                  child: suffix!,
                ),
              ),
        Text(title,
            style: GoogleFonts.tajawal(
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            )),
        InkWell(
            child: Icon(
              Icons.arrow_forward_outlined,
              size: 24.sp,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
              additionalBackFunction?.call();
            })
      ],
    );
  }
}
