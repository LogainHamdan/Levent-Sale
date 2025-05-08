import 'package:flutter/material.dart';

import '../../../models/chats.dart';
import '../../../repos/chat-repo.dart';
import '../home/data.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repo = ChatRepository();
  List<Conversation?>? chats = [];
  String errorMessage = '';
  bool isLoading = false;

  List<String> _filteredNames = names;
  List<String> _filteredImages = images;
  List<bool> _filteredStatus = onlineStatus;
  List<String> get filteredNames => _filteredNames;
  List<String> get filteredImages => _filteredImages;
  List<bool> get filteredStatus => _filteredStatus;

  void filterChats(String query) {
    if (query.isEmpty) {
      _filteredNames = names;
      _filteredImages = images;
      _filteredStatus = onlineStatus;
    } else {
      _filteredNames = names
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filteredImages =
          _filteredNames.map((name) => images[names.indexOf(name)]).toList();
      _filteredStatus = _filteredNames
          .map((name) => onlineStatus[names.indexOf(name)])
          .toList();
    }
    notifyListeners();
  }

  Future<void> fetchChats({required String token, required int userId}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _repo.getChats(token: token, userId: userId);
      chats = response.content;
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
