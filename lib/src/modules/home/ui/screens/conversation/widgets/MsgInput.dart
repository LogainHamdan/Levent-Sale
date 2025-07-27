import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class MessageInput extends StatefulWidget {
  final void Function(String message) onSend;

  const MessageInput({super.key, required this.onSend});

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  late final ConversationProvider _provider;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _provider = context.read<ConversationProvider>();
  }

  void _handleSendMessage() {
    final message = _provider.message.trim();
    if (message.isNotEmpty && !_provider.isLoading) {
      widget.onSend(message);
      _provider.clearMessage();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: grey7,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.mic, color: grey5, size: 24.sp),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: grey8,
                  ),
                  child: Selector<ConversationProvider, String>(
                    selector: (_, provider) => provider.message,
                    builder: (context, message, child) {
                      return TextField(
                        focusNode: _focusNode,
                        onSubmitted: (_) => _handleSendMessage(),
                        controller: _provider.messageController,
                        textDirection: TextDirection.rtl,
                        onChanged: _provider.updateMessage,
                        style: GoogleFonts.tajawal(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                          ),
                        ),
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالة',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontSize: 18.sp,
                              color: grey5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              right: 24.0.w, top: 13.h, bottom: 13.h),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Selector<ConversationProvider, bool>(
              selector: (context, provider) =>
                  provider.message.trim().isNotEmpty,
              builder: (context, canSend, child) {
                return IconButton(
                  onPressed: canSend && !_provider.isLoading
                      ? _handleSendMessage
                      : _handleSendMessage,
                  icon: SvgPicture.asset(
                    sendIcon,
                    height: 20.h,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
