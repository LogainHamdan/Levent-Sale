import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ConversationProvider extends ChangeNotifier {
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
}
