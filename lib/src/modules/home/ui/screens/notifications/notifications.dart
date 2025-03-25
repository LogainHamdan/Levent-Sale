import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ads/widgets/title-row.dart';
import '../chats/no-info-widget.dart';
import '../home/home.dart';
import 'data.dart';

class NotificationsScreen extends StatelessWidget {
  static const id = '/';
  final bool noData;
  const NotificationsScreen({
    super.key,
    required this.noData,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: noData
            ? Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  TitleRow(
                    onBackTap: () =>
                        Navigator.pushReplacementNamed(context, HomeScreen.id),
                    title: 'الإشعارات',
                    suffix: Image.asset(
                      'assets/imgs_icons/home/assets/icons/seen.png',
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  NoInfoWidget(
                    msg: 'لا يوجد إشعارات',
                    img:
                        'assets/imgs_icons/home/assets/icons/no-notifications.png',
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(height: 30.h),
                  TitleRow(
                      onBackTap: () => Navigator.pushReplacementNamed(
                          context, HomeScreen.id),
                      title: 'الإشعارات'),
                  Expanded(
                      child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.circle, color: Colors.green, size: 10.w),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    textDirection: TextDirection.rtl, // Set RTL
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: notifications[index]['message']!
                                                  .split(' ')
                                                  .take(2)
                                                  .join(' ') +
                                              ' ', // Extract first two words
                                          style: GoogleFonts.tajawal(
                                            // Apply Tajawal font
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: notifications[index]['message']!
                                              .split(' ')
                                              .skip(2)
                                              .join(' '), // Remaining message
                                          style: GoogleFonts.tajawal(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '5 ساعات',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
      ),
    );
  }
}
