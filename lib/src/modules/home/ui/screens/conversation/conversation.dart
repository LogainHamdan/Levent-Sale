import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/MsgInput.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/custom-app-bar.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/recieved-msg.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/widgets/sent-msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConversationScreen extends StatelessWidget {
  static const id = '/conv';
  final bool MsgsAvailable;
  const ConversationScreen({super.key, required this.MsgsAvailable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        iconAsset: 'assets/imgs_icons/home/assets/icons/more.png',
        name: 'محمد',
        profileImageAsset: 'assets/imgs_icons/home/assets/imgs/محمد.png',
      ),
      body: !MsgsAvailable
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                          'assets/imgs_icons/home/assets/icons/no-chat.png',
                          width: 200.w,
                          height: 250.h),
                      Text(
                        textDirection: TextDirection.rtl,
                        'لا يوجد محادثة !',
                        style: TextStyle(fontSize: 25.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      ReceivedMsg(
                          text: "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                      SentMsg(
                          text:
                              "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                      ReceivedMsg(
                          text: "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                      SentMsg(
                          text:
                              "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                      ReceivedMsg(
                          text: "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                      SentMsg(
                          text:
                              "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                      ReceivedMsg(
                          text: "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                      SentMsg(
                          text:
                              "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                      ReceivedMsg(
                          text: "أعتقد أن 256 جيجابايت ستكون كافية. كم سعره؟"),
                      SentMsg(
                          text:
                              "سعره هو 1200 دولار، لكن لدينا عرض خاص اليوم ب 1150 دولار"),
                    ],
                  ),
                ),
                MessageInput(),
              ],
            ),
    );
  }
}
