import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ads/widgets/title-row.dart';
import '../chats/no-info-widget.dart';
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
                  TitleRow(title: 'الإشعارات'),
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
                  TitleRow(title: 'الإشعارات'),
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
                                  Text(
                                    textDirection: TextDirection.rtl,
                                    notifications[index]['message']!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
