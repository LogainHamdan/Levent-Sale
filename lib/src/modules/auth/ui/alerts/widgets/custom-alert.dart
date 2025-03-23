import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmText,
  required Color confirmColor,
  required VoidCallback onConfirm,
  String cancelText = "إلغاء",
  Color cancelColor = Colors.red,
}) {
  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Column(
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          textDirection: TextDirection.rtl,
                          message,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, height: 1),
                ],
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(cancelText,
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                color: cancelColor,
                              ),
                            )),
                      ),
                    ),
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        child: Text(confirmText,
                            style: GoogleFonts.tajawal(
                              textStyle: TextStyle(
                                  color: confirmColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
