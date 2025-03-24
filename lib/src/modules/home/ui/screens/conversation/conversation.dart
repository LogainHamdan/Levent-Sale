import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/MsgInput.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/custom-app-bar.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/recieved-msg.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/sent-msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../chats/no-info-widget.dart';

class ConversationScreen extends StatelessWidget {
  static const id = '/conv';
  final bool msgsAvailable;

  const ConversationScreen({super.key, required this.msgsAvailable});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIcon: Image.asset(
            'assets/imgs_icons/home/assets/icons/more.png',
            height: 22.h,
          ),
          name: 'محمد',
          profileImageAsset: 'assets/imgs_icons/home/assets/imgs/محمد.png',
        ),
        body: !msgsAvailable
            ? NoInfoWidget(
                img: 'assets/imgs_icons/home/assets/icons/no-chat.png',
                msg: 'لا يوجد محادثة !')
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.all(10),
                      children: [
                        ReceivedMsg(
                            text:
                                "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                        SentMsg(
                            text:
                                "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                        ReceivedMsg(
                            text:
                                "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                        SentMsg(
                            text:
                                "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                        ReceivedMsg(
                            text:
                                "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                        SentMsg(
                            text:
                                "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                        ReceivedMsg(
                            text:
                                "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                        SentMsg(
                            text:
                                "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                        ReceivedMsg(
                            text:
                                "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                        SentMsg(
                            text:
                                "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                      ],
                    ),
                  ),
                  MessageInput(),
                ],
              ),
      ),
    );
  }
}
