import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../models/notifications.dart';
import '../ads/widgets/title-row.dart';
import '../chats/no-info-widget.dart';
import '../home/home.dart';
import 'provider.dart';

class NotificationsScreen extends StatefulWidget {
  static const id = '/notification';

  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late Future<void> _loadNotificationsFuture;

  @override
  void initState() {
    super.initState();
    _loadNotificationsFuture = _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    final token = await TokenHelper.getToken();
    final user = await UserHelper.getUser();
    await provider.getNotifications(
        token: token ?? '', recipientId: user?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: const TitleRow(title: 'الاشعارات'),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer<NotificationProvider>(
            builder: (context, provider, child) => FutureBuilder(
              future: _loadNotificationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CustomCircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ: ${snapshot.error}'));
                }

                final notifications = provider.notifications;

                if (notifications.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 30.h),
                      NoInfoWidget(
                        msg: 'لا يوجد إشعارات',
                        img: emptyNotificationsIcon,
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      GestureDetector(
                          onTap: () async {
                            await provider.markAllRead();
                          },
                          child: Text('تحديد الكل كمقروءة',
                              style: GoogleFonts.tajawal(
                                textStyle: TextStyle(
                                    color: kprimaryColor,
                                    fontWeight: !provider.allRead
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ))),
                      SizedBox(
                        height: 16.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notif = notifications[index];
                            final messageWords = notif.body.split(' ');
                            final firstTwoWords =
                                messageWords.take(2).join(' ');
                            final remainingWords =
                                messageWords.skip(2).join(' ');

                            return GestureDetector(
                              onTap: () async {
                                final token = await TokenHelper.getToken();
                                provider.selectedNotification = notif;
                                await provider.markRead(token: token ?? '');
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(notif.title,
                                              style: GoogleFonts.tajawal(
                                                  textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.sp,
                                              ))),
                                          RichText(
                                            textAlign: TextAlign.right,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '$firstTwoWords ',
                                                  style: GoogleFonts.tajawal(
                                                    //  fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: remainingWords,
                                                  style: GoogleFonts.tajawal(
                                                    fontSize: 16.sp,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              if (notif.read)
                                                SvgPicture.asset(greenSeenIcon),
                                              SizedBox(width: 8.w),
                                              GestureDetector(
                                                child: SvgPicture.asset(
                                                  deleteCollectionIcon,
                                                  height: 14.h,
                                                ),
                                                onTap: () async {
                                                  provider.selectedNotification =
                                                      notif;
                                                  await provider
                                                      .deleteNotification();
                                                  _loadNotificationsFuture;
                                                },
                                              ),
                                            ],
                                          ),
                                          Text(
                                            provider
                                                .formatDate(notif.createdAt),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    // : Icon(Icons.circle,
                                    //     color: kprimaryColor, size: 10.sp)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
