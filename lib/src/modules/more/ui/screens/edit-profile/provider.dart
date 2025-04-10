import 'dart:io';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/repositories/address-repo.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/repositories/edit-profile-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepository repository = EditProfileRepository();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController =
      TextEditingController(text: 'منة الله');
  final TextEditingController emailController =
      TextEditingController(text: 'menna@gmail.com');
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('MMMM dd, yyyy').format(DateTime.now()));
  final TextEditingController addressController =
      TextEditingController(text: 'حلب');
  final TextEditingController taxController =
      TextEditingController(text: '23456789');

  bool isCompanyAccount;
  bool isLoading = false;
  String? errorMessage;
  File? _profileImage;
  File? _coverImage;

  EditProfileProvider({this.isCompanyAccount = true});

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

  Future<void> pickImage(ImageSource source, {bool isProfile = true}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isProfile) {
        setProfileImage(File(pickedFile.path));
      } else {
        setCoverImage(File(pickedFile.path));
      }
    }
  }

  Future<void> pickCoverImage(ImageSource source,
      {bool isProfile = true}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isProfile) {
        setProfileImage(File(pickedFile.path));
      } else {
        setCoverImage(File(pickedFile.path));
      }
    }
  }

  Future<FormData> _buildFormData({
    String? firstName,
    String? lastName,
    String? birthday,
    bool? isCompanyAccount,
    File? profilePicture,
    String? businessName,
    String? businessLicense,
    String? address,
  }) async {
    final Map<String, dynamic> formMap = {
      "firstName": firstName,
      "lastName": lastName,
      "birthday": birthday,
      if (profilePicture != null)
        "profilePicture": await MultipartFile.fromFile(profilePicture.path),
    };

    if (isCompanyAccount!) {
      if (businessName != null) formMap["businessName"] = businessName;
      if (businessLicense != null) formMap["businessLicense"] = businessLicense;
      if (address != null) formMap["address"] = {"location": address};
    }

    return FormData.fromMap(formMap);
  }

  Future<void> updateProfile({
    required String token,
    String? firstName,
    String? lastName,
    DateTime? birthday,
    File? profilePicture,
    String? businessName,
    String? businessLicense,
    String? address,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final formattedBirthday = DateFormat('yyyy-MM-dd').format(birthday!);
      final formData = await _buildFormData(
        firstName: firstName,
        lastName: lastName,
        birthday: formattedBirthday,
        isCompanyAccount: isCompanyAccount,
        profilePicture: profilePicture ?? _profileImage,
        businessName: businessName,
        businessLicense: businessLicense,
        address: address,
      );

      final response = await repository.updateProfile(
        token: token,
        formData: formData,
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          print("Profile updated successfully.");
          break;
        default:
          errorMessage = "error: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage = "$e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress({
    required int addressId,
    required int id,
    required String governorate,
    required String city,
    required String fullAddress,
    required String token,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await AddressRepository.instance.updateAddress(
        addressId: addressId,
        id: id,
        governorate: governorate,
        city: city,
        fullAddress: fullAddress,
        token: token,
      );

      if (response.statusCode == 200) {
        debugPrint('Address updated successfully');
      } else {
        errorMessage = '${response.statusCode}';
        debugPrint(errorMessage!);
      }
    } catch (e) {
      errorMessage = '$e';
      debugPrint(errorMessage!);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
