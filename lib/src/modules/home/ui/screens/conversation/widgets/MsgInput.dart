import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';

class MessageInput extends StatelessWidget {
  final void Function(String message) onSend;

  const MessageInput({super.key, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     AttachSection(
            //       oneOrTwo: 1,
            //       icon: SvgPicture.asset(photoAttachIcon,
            //           height: 24.h, width: 24.w),
            //     ),
            //     SizedBox(width: 16.w),
            //     AttachSection(
            //       oneOrTwo: 2,
            //       icon: SvgPicture.asset(linkAttachIcon,
            //           height: 24.h, width: 24.w),
            //     ),
            //   ],
            // ),
            // SizedBox(width: 16.w),
            Icon(
              Icons.mic,
              color: grey5,
              size: 24.sp,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: grey8,
                  ),
                  child: TextField(
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        onSend(value.trim());
                        context.read<ConversationProvider>().clearMessage();
                      }
                    },
                    controller:
                        context.read<ConversationProvider>().messageController,
                    textDirection: TextDirection.rtl,
                    onChanged: (value) => context
                        .read<ConversationProvider>()
                        .updateMessage(value),
                    style: GoogleFonts.tajawal(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                      ),
                    ),
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالة',
                      hintTextDirection: TextDirection.rtl,
                      hintStyle: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: grey5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          right: 24.0.w, top: 13.h, bottom: 13.h),
                    ),
                  ),
                ),
              ),
            ),
            Selector<ConversationProvider, String>(
              selector: (_, provider) => provider.message,
              builder: (context, message, child) {
                return message.trim().isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          onSend(message.trim());
                          context.read<ConversationProvider>().clearMessage();
                        },
                        icon: SvgPicture.asset(sendIcon, height: 20.h),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
