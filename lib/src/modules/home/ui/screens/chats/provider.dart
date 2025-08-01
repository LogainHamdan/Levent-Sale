import 'package:flutter/material.dart';

import '../../../models/chats.dart';
import '../../../models/conversation.dart';
import '../../../repos/chat-repo.dart';
import '../home/data.dart';

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repo = ChatRepository();
  List<Conversation?>? chats = [];

  String errorMessage = '';
  bool isLoading = false;
  List<Conversation?>? privateChats;
  List<Conversation?>? adsChats;
  List<String> _filteredNames = names;
  List<String> _filteredImages = images;
  List<bool> _filteredStatus = onlineStatus;
  List<String> get filteredNames => _filteredNames;
  List<String> get filteredImages => _filteredImages;
  List<bool> get filteredStatus => _filteredStatus;
  int _currentIndex = 0;
  final PageController pageController = PageController();

  int get currentIndex => _currentIndex;
  void changeTab(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void getChatsWithAds() {
    adsChats = chats?.where((chat) => chat?.lastMessage?.adId != 0).toList();
  }

  void getPrivateChats() {
    privateChats =
        chats?.where((chat) => chat?.lastMessage?.adId == 0).toList();
  }

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

  int getTotalUnreadMessages() {
    return chats
            ?.where((c) => c != null)
            .map((c) => c!.unreadMessages)
            .fold(0, (sum, count) => sum! + count!) ??
        0;
  }

  Future<void> fetchChats({required String token, required int userId}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _repo.getChats(token: token, userId: userId);
      chats = response.content;
      chats?.sort((a, b) {
        final aTime =
            a?.lastMessage?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime =
            b?.lastMessage?.sentAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
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
