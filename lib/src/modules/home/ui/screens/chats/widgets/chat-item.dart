import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/home/models/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../../../auth/models/user.dart';
import '../../../../../more/models/profile.dart';
import '../../../../../more/ui/screens/edit-profile/provider.dart';
import '../provider.dart';

class ChatItem extends StatelessWidget {
  final Message? message;
  final String time;
  final int senderId;
  final int adId;

  ChatItem({
    required this.message,
    required this.time,
    required this.senderId,
    required this.adId,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    final provider = Provider.of<LoginProvider>(context, listen: false);

    return FutureBuilder(
      future: Future.wait([
        UserHelper.getUser(),
        //    profileProvider.getProfile(userId: senderId),
        provider.getUserById(id: senderId)
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CustomCircularProgressIndicator());
        }

        final User? currentUser = snapshot.data![0];
        final User? senderUser = snapshot.data![1];

        return GestureDetector(
          onTap: () async {
            final provider =
                Provider.of<ConversationProvider>(context, listen: false);
            final token = await TokenHelper.getToken();
            print('message ud: ${message?.id}');
            await provider.markAsRead(token: token ?? "", [message?.id ?? '']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationScreen(
                  adId: adId,
                  userId: currentUser?.id ?? 0,
                  receiverId: senderId,
                ),
              ),
            ).then((_) {
              Provider.of<ChatProvider>(context, listen: false).fetchChats(
                token: token ?? '',
                userId: currentUser?.id ?? 0,
              );
            });
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(senderUser?.profilePicture ?? ""),
                    radius: 25.r,
                  ),
                  if (senderUser?.active ?? false)
                    Positioned(
                      bottom: 2,
                      left: 2,
                      child: Container(
                        width: 12.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                senderUser?.username ?? 'Unknown User',
                style: GoogleFonts.tajawal(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              subtitle: message?.readAt == null &&
                      message?.receiverId == currentUser?.id
                  ? Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      message?.content ?? '',
                      style: GoogleFonts.tajawal(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Text(
                      message?.content ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
              trailing: Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        );
      },
    );
  }
}
