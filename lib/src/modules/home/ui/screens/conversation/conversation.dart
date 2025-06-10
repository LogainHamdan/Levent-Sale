import 'dart:convert';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/MsgInput.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/chat-ad-container.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/custom-app-bar.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/sent-message.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/received-message.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/friend-profile.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../../../../more/ui/screens/edit-profile/provider.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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
    await provider.fetchConversation(
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
    _scrollController.dispose();
    stompClient.deactivate();
    Provider.of<ConversationProvider>(context, listen: false)
        .resetConversation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    print('receiver: ${widget.receiverId}');
    return FutureBuilder(
      future: profileProvider.getProfile(userId: widget.receiverId),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              userId: widget.receiverId,
              leadingIcon: SvgPicture.asset(moreIcon, height: 22.h),
              name: snapshot.data?.username ?? '',
              profileImageAsset: snapshot.data?.profilePicture ?? '',
            ),
            body: Consumer<ConversationProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.isLoading) {
                  return Center(child: CustomCircularProgressIndicator());
                }

                if (chatProvider.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${chatProvider.errorMessage}'));
                }

                if (chatProvider.chatMessages == null ||
                    chatProvider.chatMessages!.content == null ||
                    chatProvider.chatMessages!.content!.isEmpty) {
                  return NoInfoWidget(
                    bottomWidget: true,
                    img: emptyChatIcon,
                    msg: 'لا يوجد محادثة !',
                    lowerWidget: MessageInput(
                      onSend: sendMessage,
                    ),
                  );
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  }
                });
                final sortedMessages =
                    List.of(chatProvider.chatMessages!.content!)
                      ..sort((a, b) {
                        final aTime =
                            a?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        final bTime =
                            b?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
                        return aTime.compareTo(bTime);
                      });
                final homeProvider =
                    Provider.of<HomeProvider>(context, listen: false);

                return FutureBuilder(
                  future: homeProvider.getAdById(widget.adId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CustomCircularProgressIndicator();
                    }
                    final ad = snapshot.data;
                    return Column(
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        ChatAdContainer(ad: ad),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.all(10.sp),
                            itemCount: sortedMessages.length,
                            itemBuilder: (context, index) {
                              final message = sortedMessages[index];

                              if (message?.senderId == widget.userId) {
                                return SentMsg(
                                  seen: message?.readAt != null,
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 25.0.h),
                          child: MessageInput(onSend: sendMessage),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
