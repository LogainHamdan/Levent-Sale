import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileProvider extends ChangeNotifier {
  bool isCompanyAccount;

  File? _profileImage;
  File? _coverImage;

  EditProfileProvider({this.isCompanyAccount = true});

  final ImagePicker _picker = ImagePicker();

  File? get profileImage => _profileImage;
  File? get coverImage => _coverImage;

  void setProfileImage(File? selectedImage) {
    _profileImage = selectedImage;
    notifyListeners();
  }

  void setCoverImage(File? selectedImage) {
    _coverImage = selectedImage;
    notifyListeners();
  }

  Future<void> pickProfileImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setProfileImage(File(pickedFile.path));
    }
  }

  Future<void> pickCoverImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setCoverImage(File(pickedFile.path));
    }
  }
}
