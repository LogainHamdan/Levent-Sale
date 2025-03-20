import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileProvider extends ChangeNotifier {
  bool isCompanyAccount;
  String? profileImage;
  String? coverImage;

  ProfileProvider({this.isCompanyAccount = true});

  Future<void> pickImage(bool isProfile) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery); // Pick from gallery

    if (image != null) {
      if (isProfile) {
        profileImage = image.path;
      } else {
        coverImage = image.path;
      }
      notifyListeners();
    }
  }

  void removeImage(bool isProfile) {
    if (isProfile) {
      profileImage = null;
    } else {
      coverImage = null;
    }
    notifyListeners();
  }
}
