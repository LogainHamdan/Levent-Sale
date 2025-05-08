import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/MsgInput.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/custom-app-bar.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/recieved-msg.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/sent-msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../../../../more/ui/screens/profile/provider.dart';
import '../chats/no-info-widget.dart';

class ConversationScreen extends StatefulWidget {
  final int adId;
  final int userId;
  final int receiverId;
  static const id = '/conv';

  const ConversationScreen({
    super.key,
    required this.adId,
    required this.userId,
    required this.receiverId,
  });

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  late StompClient stompClient;

  @override
  void initState() {
    super.initState();
    _loadConversation();
    _connectStomp();
  }

  void _connectStomp() {
    print('Attempting to connect');
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://37.148.208.169:8086/ws-chat/websocket',
        onConnect: _onConnect,
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        onStompError: (frame) => print('STOMP Error: ${frame.body}'),
        onDisconnect: (_) => print('Disconnected from WebSocket'),
        heartbeatIncoming: Duration(seconds: 0),
        heartbeatOutgoing: Duration(seconds: 0),
        reconnectDelay: Duration(seconds: 5),
      ),
    );

    stompClient.activate();
    print('WebSocket connection attempt completed.');
  }

  void _onConnect(StompFrame frame) {
    print('Connected to STOMP server.');
    stompClient.subscribe(
      destination: '/topic/public',
      callback: (frame) {
        if (frame.body != null) {
          final provider =
              Provider.of<ConversationProvider>(context, listen: false);
          provider.receiveMessage(frame.body!);
          print('Message received: ${frame.body}');
        }
      },
    );
  }

  void sendMessage(String messageContent) async {
    final message = {
      "content": messageContent,
      "senderId": widget.userId,
      "receiverId": widget.receiverId,
      "adId": widget.adId,
    };

    print('Sending message: $message');

    try {
      stompClient.send(
        destination: "/app/chat.sendMessage",
        body: jsonEncode(message),
        headers: {
          "content-type": "application/json",
        },
      );

      print('Message sent successfully: $messageContent');

      final provider =
          Provider.of<ConversationProvider>(context, listen: false);
      provider.addLocalMessage(messageContent, widget.userId);
    } catch (error) {
      print('Error sending message: $error');

      print('error sending msg');
    }
  }

  Future<void> _loadConversation() async {
    final token = await TokenHelper.getToken();
    final provider = Provider.of<ConversationProvider>(context, listen: false);
    provider.fetchConversation(
      token: token ?? '',
      senderId: widget.userId,
      receiverId: widget.receiverId,
      adId: widget.adId,
      page: 0,
      limit: 10,
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    return FutureBuilder(
      future: profileProvider.getProfile(userId: widget.receiverId),
      builder: (context, snapshot) => SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            leadingIcon: SvgPicture.asset(moreIcon, height: 22.h),
            name: snapshot.data?.username ?? '',
            profileImageAsset: snapshot.data?.profilePicture ?? '',
          ),
          body: Consumer<ConversationProvider>(
            builder: (context, chatProvider, child) {
              if (chatProvider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (chatProvider.errorMessage.isNotEmpty) {
                return Center(
                    child: Text('Error: ${chatProvider.errorMessage}'));
              }

              if (chatProvider.chatMessages == null ||
                  chatProvider.chatMessages!.content == null ||
                  chatProvider.chatMessages!.content!.isEmpty) {
                return NoInfoWidget(
                  img: emptyChatIcon,
                  msg: 'لا يوجد محادثة !',
                  lowerWidget: MessageInput(
                    onSend: sendMessage,
                  ),
                );
              }
              final sortedMessages =
                  List.of(chatProvider.chatMessages!.content!)
                    ..sort((a, b) {
                      final aTime =
                          a?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                      final bTime =
                          b?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                      return aTime.compareTo(bTime);
                    });

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.sp),
                      itemCount: sortedMessages.length,
                      itemBuilder: (context, index) {
                        final message = sortedMessages[index];

                        if (message?.senderId == widget.userId) {
                          return SentMsg(
                            text: message?.content ?? '',
                            time: message?.sentAt ?? DateTime.now(),
                          );
                        } else {
                          return ReceivedMsg(
                            text: message?.content ?? '',
                            time: message?.sentAt ?? DateTime.now(),
                          );
                        }
                      },
                    ),
                  ),
                  MessageInput(onSend: sendMessage),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
