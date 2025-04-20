import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleRow extends StatelessWidget {
  final Function()? additionalBackFunction;
  final String title;
  final bool? noBack;

  const TitleRow({
    super.key,
    required this.title,
    this.additionalBackFunction,
    this.noBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.tajawal(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            additionalBackFunction?.call();
          },
          child: noBack!
              ? SizedBox()
              : Icon(
                  Icons.arrow_forward,
                  size: 24.sp,
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
