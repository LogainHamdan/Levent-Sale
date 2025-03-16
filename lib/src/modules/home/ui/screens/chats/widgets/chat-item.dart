import 'package:Levant_Sale/src/modules/home/ui/screens/conversation/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  final bool isOnline;

  ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.imageUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushReplacementNamed(context, ConversationScreen.id),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
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
            name,
          ),
          subtitle: isOnline
              ? Text(message, style: Theme.of(context).textTheme.bodyMedium)
              : Text(message, style: Theme.of(context).textTheme.bodySmall),
          trailing: Text(
            time,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
