import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/conversation.dart';
import '../../../repos/chat-repo.dart';

import 'dart:convert';

class ConversationProvider extends ChangeNotifier {
  final ChatRepository _repo = ChatRepository();

  bool _isLoading = false;
  bool _isRead = false;
  ChatMessageResponse? _chatMessages;
  String _errorMessage = '';
  String _message = '';

  File? _selectedImage1;
  File? _selectedImage2;

  final TextEditingController messageController = TextEditingController();

  // Getters
  bool get isLoading => _isLoading;
  bool get isRead => _isRead;
  ChatMessageResponse? get chatMessages => _chatMessages;
  String get errorMessage => _errorMessage;
  String get message => _message;
  File? get selectedImage1 => _selectedImage1;
  File? get selectedImage2 => _selectedImage2;

  // Selectors for better performance
  List<ChatMessage?> get sortedMessages {
    if (_chatMessages?.content == null) return [];

    final messages = List<ChatMessage?>.from(_chatMessages!.content!);
    messages.sort((a, b) {
      final aTime = a?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return aTime.compareTo(bTime);
    });
    return messages;
  }

  bool get hasMessages => _chatMessages?.content?.isNotEmpty == true;

  void updateMessage(String newMessage) {
    if (_message != newMessage) {
      _message = newMessage;
    }
  }

  void clearMessage() {
    if (_message.isNotEmpty) {
      _message = '';
      messageController.clear();
      notifyListeners();
    }
  }

  void addLocalMessage(String content, int senderId) {
    final newMessage = ChatMessage(
        content: content, senderId: senderId, sentAt: DateTime.now());

    if (_chatMessages != null && _chatMessages!.content != null) {
      _chatMessages!.content!.add(newMessage); // add to end for natural order
    } else {
      _chatMessages = ChatMessageResponse(content: [newMessage]);
    }
    notifyListeners();
  }

  void resetConversation() {
    _chatMessages = null;
    _isLoading = false;
    _errorMessage = '';
    _message = '';
    messageController.clear();
    notifyListeners();
  }

  void receiveMessage(String rawMessage) {
    try {
      final decoded = jsonDecode(rawMessage);
      final newMessage = ChatMessage.fromJson(decoded);

      if (_chatMessages != null && _chatMessages!.content != null) {
        _chatMessages!.content!.insert(0, newMessage);
      } else {
        _chatMessages = ChatMessageResponse(content: [newMessage]);
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
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _chatMessages = await _repo.getConversation(
        token: token,
        senderId: senderId,
        receiverId: receiverId,
        adId: adId,
        page: page,
        limit: limit,
      );
    } catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsRead(List<String> msgIds, {required String token}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _isRead = await _repo.markAsRead(msgIds, token: token);
    } catch (e) {
      print(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
