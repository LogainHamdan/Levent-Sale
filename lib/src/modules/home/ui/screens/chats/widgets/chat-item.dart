import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/models/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '../../../../../more/ui/screens/edit-profile/provider.dart';

class ChatItem extends StatelessWidget {
  final Message? message;
  final String time;
  final bool isOnline;
  final int senderId;
  final int adId;

  ChatItem({
    required this.message,
    required this.time,
    required this.isOnline,
    required this.senderId,
    required this.adId,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);

    return FutureBuilder(
      future: Future.wait([
        UserHelper.getUser(),
        profileProvider.getProfile(userId: senderId),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentUser = snapshot.data![0];
        final senderUser = snapshot.data![1];

        return GestureDetector(
          onTap: () async {
            final provider =
                Provider.of<ConversationProvider>(context, listen: false);
            final token = await TokenHelper.getToken();
            await provider.markAsRead([message?.id ?? ''], token: token ?? '');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConversationScreen(
                  adId: adId,
                  userId: currentUser?.id ?? 0,
                  receiverId: senderId,
                ),
              ),
            );
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
              subtitle: isOnline
                  ? Text(
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
