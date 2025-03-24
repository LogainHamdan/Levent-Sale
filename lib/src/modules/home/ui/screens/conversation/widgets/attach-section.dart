import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class AttachSection extends StatelessWidget {
  final Widget icon;
  final int oneOrTwo;
  const AttachSection({
    super.key,
    required this.icon,
    required this.oneOrTwo,
  });

  @override
  Widget build(BuildContext context) {
    return oneOrTwo == 1
        ? GestureDetector(
            onTap: () => context.read<ConversationProvider>().pickImage1(),
            child: Consumer<ConversationProvider>(
              builder: (context, provider, child) {
                return provider.selectedImage1 != null
                    ? Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.white, width: 1.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            provider.selectedImage1!,
                            width: 50.w,
                            height: 50.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : icon;
              },
            ),
          )
        : GestureDetector(
            onTap: () => context.read<ConversationProvider>().pickImage2(),
            child: Consumer<ConversationProvider>(
              builder: (context, provider, child) {
                return provider.selectedImage2 != null
                    ? Container(
                        width: 50.w,
                        height: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.white, width: 1.w),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: Image.file(
                            provider.selectedImage2!,
                            width: 50.w,
                            height: 50.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : icon;
              },
            ),
          );
  }
}
