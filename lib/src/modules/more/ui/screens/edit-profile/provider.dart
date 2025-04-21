import 'dart:convert';
import 'dart:io';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/more/repositories/address-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/edit-profile-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../auth/repos/user-helper.dart';
import '../../../../home/models/address.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepository repository = EditProfileRepository();
  final ImagePicker _picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();

  bool isCompanyAccount = false;
  bool isLoading = false;
  String? errorMessage;
  File? _profileImage;
  File? _coverImage;

  File? get profileImage => _profileImage;

  File? get coverImage => _coverImage;
  Future<void> init() async {
    final user = await UserHelper.getUser();
    if (user != null) {
      nameController.text = '${user.firstName ?? ''} ${user.lastName ?? ''}';
      emailController.text = user.email ?? '';
      phoneController.text = user.phoneNumber ?? '';
      dateController.text = user.birthday.toString() ?? '';
      addressController.text = user.address?.fullAddress ?? '';
      taxController.text = user.businessLicense ?? '';
      businessNameController.text = user.businessName ?? '';
      isCompanyAccount = checkIfCompanyAccount(user.roles);
    }
    notifyListeners();
  }

  bool checkIfCompanyAccount(List<String>? roles) {
    return roles?.contains('business-owner') ?? false;
  }

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

  Future<Map<String, dynamic>> _buildJsonBody({
    String? firstName,
    String? lastName,
    String? birthday,
    String? profilePicture,
    String? businessName,
    String? businessLicense,
    Address? address,
  }) async {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "birthday": birthday,
      "businessName": businessName,
      "businessLicense": businessLicense,
      "address": address != null &&
              address.governorate != null &&
              address.city != null &&
              address.fullAddress != null
          ? {
              "governorate": address.governorate,
              "city": address.city,
              "fullAddress": address.fullAddress,
            }
          : null,
    };
  }

  Future<String> convertImageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    String base64String = base64Encode(bytes);

    base64String = base64String.split(" ")[1].trim();

    return base64String;
  }

  Future<void> updateProfile({
    required String token,
    String? firstName,
    String? lastName,
    String? birthday,
    File? profilePicture,
    String? businessName,
    String? businessLicense,
    Address? address,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      String? base64ProfilePicture;
      if (profilePicture != null) {
        base64ProfilePicture = await convertImageToBase64(profilePicture);
      }

      final jsonBody = await _buildJsonBody(
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        profilePicture: base64ProfilePicture,
        businessName: businessName,
        businessLicense: businessLicense,
        address: address,
      );

      final response = await repository.updateProfile(
        jsonBody: jsonBody,
        token: token,
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          print("Profile updated successfully.");
          break;
        default:
          errorMessage = "error: ${response.statusCode}";
          print(
              "Failed to update profile. Status code: ${response.statusCode}");
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
      print("Error updating profile: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress({
    int? addressId,
    int? id,
    String? governorate,
    String? city,
    String? fullAddress,
    String? token,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    final user = await UserHelper.getUser();
    try {
      final response = await AddressRepository.instance.updateAddress(
        addressId: addressId ?? user?.address?.id ?? 0,
        id: id ?? user?.id ?? 0,
        governorate: governorate ?? user?.address?.governorate ?? '',
        city: city ?? user?.address?.city ?? '',
        fullAddress: fullAddress ?? user?.address?.fullAddress ?? '',
        token: token ?? '',
      );
      print(response.statusCode);
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
