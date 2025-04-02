import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'attach-section.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key});

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
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AttachSection(
                  oneOrTwo: 1,
                  icon: SvgPicture.asset(
                    photoAttachIcon,
                    height: 20.w,
                  ),
                ),
                SizedBox(width: 8.w),
                AttachSection(
                  oneOrTwo: 2,
                  icon: SvgPicture.asset(
                    linkAttachIcon,
                    height: 20.w,
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            // Expanded TextField
            Expanded(
              child: TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) =>
                    context.read<ConversationProvider>().updateMessage(value),
                decoration: InputDecoration(
                  hintText: 'اكتب رسالة',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: InputBorder.none,
                ),
              ),
            ),

            Consumer<ConversationProvider>(
              builder: (context, messageProvider, child) {
                return messageProvider.message.trim().isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          // Handle send action
                        },
                        icon: SvgPicture.asset(
                          sendIcon,
                          height: 20.h,
                        ),
                      )
                    : SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
