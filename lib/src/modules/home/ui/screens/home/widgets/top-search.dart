import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/join-chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/notifications/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../notifications/notifications.dart';
import 'icon-stack.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController homeSearchController = TextEditingController();

    return FutureBuilder(
      future: UserHelper.getUser(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Row(
          children: [
            Consumer<NotificationProvider>(builder: (context, provider, child) {
              return provider.isLoading == true
                  ? CustomCircularProgressIndicator()
                  : IconStack(
                      onTap: () => user != null
                          ? Navigator.pushNamed(context, NotificationsScreen.id)
                          : loginFirstAlert(context),
                      img: notificationsIcon,
                      count:
                          '${provider.notificationStats?.unreadNotifications ?? 0}');
            }),
            SizedBox(width: 8.w),
            Consumer<ChatProvider>(builder: (context, provider, child) {
              return provider.isLoading == true
                  ? CustomCircularProgressIndicator()
                  : IconStack(
                      onTap: () => user != null
                          ? Navigator.pushNamed(context, JoinChats.id)
                          : loginFirstAlert(context),
                      img: chatBlackIcon,
                      count: '${provider.getTotalUnreadMessages()}');
            }),
            SizedBox(width: 16.w),
            Expanded(
              child: SearchField(
                controller: homeSearchController,
              ),
            ),
          ],
        );
      },
    );
  }
}
