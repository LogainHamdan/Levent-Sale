import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/widgets/chat-item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../auth/repos/token-helper.dart';
import '../ads/widgets/title-row.dart';
import '../home/widgets/search-field.dart';
import 'no-info-widget.dart';

class ChatListScreen extends StatefulWidget {
  static const id = '/ChatListScreen';

  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  TextEditingController chatsController = TextEditingController();

  Future<void> _loadChats() async {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final token = await TokenHelper.getToken();
    final user = await UserHelper.getUser();
    final userId = user?.id ?? 0;
    chatProvider.fetchChats(token: token ?? '', userId: userId);
  }

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: const TitleRow(title: 'المحادثات'),
      ),
      body: SafeArea(
        child: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            if (chatProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (chatProvider.errorMessage.isNotEmpty) {
              return Center(child: Text(chatProvider.errorMessage));
            }
            if (chatProvider.chats?.isEmpty ?? true) {
              return NoInfoWidget(img: emptyChatIcon, msg: 'لا توجد محادثات !');
            }
            return Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.all(8.0.sp),
                //   child: SearchField(
                //     width: 327,
                //     hasFilterIcon: false,
                //     controller: chatsController,
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: chatProvider.chats?.length,
                    itemBuilder: (context, index) {
                      final conversation = chatProvider.chats?[index];
                      final chatProfile = conversation?.chatProfile;
                      final lastMessage = conversation?.lastMessage;
                      return ChatItem(
                        adId: lastMessage?.adId ?? 0,
                        message: lastMessage,
                        time:
                            '${lastMessage?.sentAt.hour}:${lastMessage?.sentAt.minute}',
                        isOnline: conversation?.unreadMessages != 0,
                        senderId: lastMessage?.senderId ?? 0,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
