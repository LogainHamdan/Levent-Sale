import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  bool isCompanyAccount;

  File? _image;

  EditProfileProvider({this.isCompanyAccount = true});

  final ImagePicker _picker = ImagePicker();

  File? get image => _image;

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
}
