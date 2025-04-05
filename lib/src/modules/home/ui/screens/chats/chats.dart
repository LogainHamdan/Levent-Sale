import 'package:Levant_Sale/src/modules/home/ui/screens/chats/widgets/chat-item.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main/ui/screens/main_screen.dart';
import '../ads/widgets/title-row.dart';
import '../home/data.dart';
import '../home/home.dart';
import '../home/widgets/search-field.dart';
import 'no-info-widget.dart';

class ChatListScreen extends StatelessWidget {
  static const id = '/ChatListScreen';

  const ChatListScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController chatsController = TextEditingController();

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 16.h,
          ),
          TitleRow(title: 'المحادثات'),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: SearchField(
              width: 327,
              hasFilterIcon: false,
              controller: chatsController,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final name = names[index % names.length];
                final image = images[index % images.length];
                final isOnline = onlineStatus[index % onlineStatus.length];

                return ChatItem(
                    name: name,
                    message: 'اريد ان ارى صور..',
                    time: '5 ساعات',
                    imageUrl: image,
                    isOnline: isOnline);
              },
            ),
          ),
        ],
      ),
    ));
  }
}
