import 'package:Levant_Sale/src/modules/home/ui/screens/chats/widgets/chat-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ads/widgets/title-row.dart';
import '../home/data.dart';
import '../home/widgets/search-field.dart';

class ChatListScreen extends StatelessWidget {
  static const id = '/ChatListScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          TitleRow(title: 'المحادثات'),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: SearchField(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final name = names[index % names.length];
                final image = images[index % images.length];
                final isOnline = onlineStatus[index % onlineStatus.length];

                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListTile(
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(image),
                          radius: 25.r,
                        ),
                        if (isOnline)
                          Positioned(
                            bottom: 2,
                            left: 2,
                            child: Container(
                              width: 12.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(name),
                    subtitle: Text('اريد ان ارى صور..'),
                    trailing: Text(
                      '5 ساعات',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
