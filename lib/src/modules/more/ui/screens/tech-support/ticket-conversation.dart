import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../../../../home/ui/screens/chats/no-info-widget.dart';
import '../../../../home/ui/screens/conversation/widgets/MsgInput.dart';
import '../../../../home/ui/screens/conversation/widgets/custom-app-bar.dart';
import '../../../../home/ui/screens/conversation/widgets/received-message.dart';
import '../../../../home/ui/screens/conversation/widgets/sent-message.dart';
import '../../../models/ticket.dart';

class TicketConversationScreen extends StatefulWidget {
  final String ticketId;

  const TicketConversationScreen({Key? key, required this.ticketId})
      : super(key: key);

  @override
  State<TicketConversationScreen> createState() =>
      _TicketConversationScreenState();
}

class _TicketConversationScreenState extends State<TicketConversationScreen> {
  late String senderId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSenderId();
    _loadMessages();
  }

  Future<void> _loadSenderId() async {
    final user = await UserHelper.getUser();
    senderId = '${user?.id}';
    setState(() {});
  }

  Future<void> _loadMessages() async {
    final token = await TokenHelper.getToken();
    await Provider.of<TechSupportProvider>(context, listen: false)
        .getTicketMsgs(token: token ?? '', ticketId: widget.ticketId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: SizedBox(),
        name: 'الدعم الفني',
        profileImageAsset: personIcon,
      ),
      body: Consumer<TechSupportProvider>(
        builder: (context, techSupportProvider, child) {
          if (techSupportProvider.errorMessage != null) {
            return Center(
              child: Text('Error: ${techSupportProvider.errorMessage}'),
            );
          }

          if (techSupportProvider.isLoading) {
            return CustomCircularProgressIndicator();
          }

          final messages = techSupportProvider.ticketMsgs;

          if (messages.isEmpty) {
            return NoInfoWidget(
              bottomWidget: true,
              img: emptyChatIcon,
              msg: 'لا يوجد رسائل !',
              lowerWidget: MessageInput(
                onSend: (message) async {},
              ),
            );
          }

          final sortedMessages = List.of(messages)
            ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(10.sp),
                  itemCount: sortedMessages.length,
                  itemBuilder: (context, index) {
                    final message = sortedMessages[index];

                    if (message.senderType == SenderType.USER) {
                      return SentMsg(
                        text: message.message,
                        time: message.sentAt,
                      );
                    } else if (message.senderType == SenderType.ADMIN) {
                      return ReceivedMsg(
                        text: message.message,
                        time: message.sentAt,
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ),
              MessageInput(
                onSend: (message) async {
                  final token = await TokenHelper.getToken();
                  if (token != null) {
                    await techSupportProvider.replyTicket(
                      message: message,
                      token: token,
                      ticketId: widget.ticketId,
                    );

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
