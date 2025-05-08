import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/chats.dart';
import '../../../models/conversation.dart';
import '../../../repos/chat-repo.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/chats.dart';
import '../../../models/conversation.dart';
import '../../../repos/chat-repo.dart';

class ConversationProvider extends ChangeNotifier {
  final ChatRepository _repo = ChatRepository();

  bool isLoading = false;
  bool isRead = false;
  ChatMessageResponse? chatMessages;
  String errorMessage = '';

  File? _selectedImage1;
  File? _selectedImage2;

  String _message = '';

  String get message => _message;
  File? get selectedImage1 => _selectedImage1;
  File? get selectedImage2 => _selectedImage2;

  void updateMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  void addLocalMessage(String content, int senderId) {
    final newMessage = ChatMessage(
        content: content, senderId: senderId, sentAt: DateTime.now());

    if (chatMessages != null && chatMessages!.content != null) {
      chatMessages!.content!.insert(0, newMessage);
    } else {
      chatMessages = ChatMessageResponse(content: [newMessage]);
    }

    notifyListeners();
  }

  void receiveMessage(String rawMessage) {
    try {
      final decoded = jsonDecode(rawMessage);
      final newMessage = ChatMessage.fromJson(decoded);

      if (chatMessages != null && chatMessages!.content != null) {
        chatMessages!.content!.insert(0, newMessage);
      } else {
        chatMessages = ChatMessageResponse(content: [newMessage]);
      }

      notifyListeners();
    } catch (e) {
      print("Error parsing incoming message: $e");
    }
  }

  Future<void> pickImage1() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage1 = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickImage2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _selectedImage2 = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> fetchConversation({
    required String token,
    required int senderId,
    required int receiverId,
    required int adId,
    required int page,
    required int limit,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      chatMessages = await _repo.getConversation(
        token: token,
        senderId: senderId,
        receiverId: receiverId,
        adId: adId,
        page: page,
        limit: limit,
      );
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead({
    required String token,
    required String firstMsgId,
    required String secondMsgId,
    required String thirdMsgId,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      isRead = await _repo.markAsRead(
        token: token,
        firstMsgId: firstMsgId,
        secondMsgId: secondMsgId,
        thirdMsgId: thirdMsgId,
      );
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
