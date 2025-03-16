import 'package:flutter/material.dart';

import '../home/data.dart';

class ChatProvider extends ChangeNotifier {
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
}
