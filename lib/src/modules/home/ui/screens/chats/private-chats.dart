import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/widgets/chat-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../auth/models/user.dart';
import '../../../../auth/repos/token-helper.dart';
import '../ads/widgets/title-row.dart';
import '../home/widgets/custom-indicator.dart';
import '../home/widgets/search-field.dart';
import 'no-info-widget.dart';

class PrivateChatListScreen extends StatelessWidget {
  final User currentUser;

  const PrivateChatListScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.isLoading) {
          return const Center(child: CustomCircularProgressIndicator());
        }
        if (chatProvider.errorMessage.isNotEmpty) {
          return Center(child: Text(chatProvider.errorMessage));
        }
        if (chatProvider.privateChats?.isEmpty ?? true) {
          return NoInfoWidget(
            img: emptyChatIcon,
            msg: 'لا توجد محادثات خاصة!',
          );
        }

        return ListView.builder(
          itemCount: chatProvider.privateChats?.length ?? 0,
          itemBuilder: (context, index) {
            final conversation = chatProvider.privateChats?[index];
            final lastMessage = conversation?.lastMessage;
            return ChatItem(
              adId: lastMessage?.adId ?? 0,
              message: lastMessage,
              time:
                  '${lastMessage?.sentAt?.hour}:${lastMessage?.sentAt?.minute}',
              senderId: lastMessage?.senderId == currentUser.id
                  ? lastMessage?.receiverId ?? 0
                  : lastMessage?.senderId ?? 0,
            );
          },
        );
      },
    );
  }
}
