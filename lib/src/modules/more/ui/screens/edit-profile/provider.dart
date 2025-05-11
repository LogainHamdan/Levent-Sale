import 'dart:convert';
import 'dart:io';
import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/more/repositories/address-repo.dart';
import 'package:Levant_Sale/src/modules/more/repositories/edit-profile-repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/user-helper.dart';
import '../../../models/profile.dart';
import '../../../repositories/follow-repo.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepository repository = EditProfileRepository();
  final ImagePicker _picker = ImagePicker();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController businessLicenseController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();

  bool isCompanyAccount = false;
  bool isLoading = false;
  String? errorMessage;
  File? _profileImage;
  File? _coverImage;
  final FollowRepository followRepository = FollowRepository();

  Profile? profile;
  String? error;

  File? get profileImage => _profileImage;

  File? get coverImage => _coverImage;

  Future<void> init() async {
    final user = await UserHelper.getUser();
    final profile = await getProfile(userId: user?.id ?? 0);
    if (profile != null) {
      firstNameController.text = profile.firstName ?? '';
      lastNameController.text = profile.lastName ?? '';
      dateController.text = profile.birthday.toString() ?? '';
      addressController.text = profile.address?.fullAddresse ?? '';
      businessNameController.text = profile.businessName ?? '';
      businessLicenseController.text = profile.businessLicense ?? '';
      isCompanyAccount = checkIfCompanyAccount(user?.roles);
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

  Future<void> pickImage(BuildContext context, ImageSource source,
      {bool isProfile = true}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isProfile) {
        setProfileImage(File(pickedFile.path));
        Navigator.of(context).pop();
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

  static String encryptImage({
    required File image,
  }) {
    return 'data:image/${image.path.substring(image.path.lastIndexOf('.') + 1)};base64,${base64Encode(image.readAsBytesSync())}';
  }

  Future<void> updateProfile({
    required String token,
    String? firstName,
    String? lastName,
    String? birthday,
    File? profilePicture,
    String? businessLicense,
    String? governorateId,
    String? cityId,
    String? fullAddress,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      //
      // final encryptedProfilePicture =
      //     profilePicture != null ? encryptImage(image: profilePicture) : "";

      final updatedProfile = await repository.updateProfile(
        token: token,
        firstName: firstName ?? "",
        lastName: lastName ?? "",
        birthday: birthday ?? "",
        profilePicture: profilePicture,
        businessLicense: businessLicense ?? "",
        governorateId: governorateId ?? '2',
        cityId: cityId ?? '14',
        fullAddress: fullAddress ?? '',
      );
    } catch (e, stack) {
      errorMessage = "An error occurred while updating profile: $e";
      print("Error updating profile: $e");
      print("Stack trace: $stack");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Profile?> getProfile({required int userId}) async {
    try {
      final profile = await followRepository.getProfile(userId: userId);
      print('Profile loaded successfully: ${profile?.username}');
      error = null;
      return profile;
    } catch (e) {
      profile = null;

      if (e is DioException) {
        error = "Error: ${e.message}";
      } else {
        error = "An unexpected error occurred: $e";
      }

      print(error);
      notifyListeners();

      return null;
    }
  }
  //
  // Future<void> updateAddress({
  //   int? addressId,
  //   int? id,
  //   String? governorate,
  //   String? city,
  //   String? fullAddress,
  //   String? token,
  // }) async {
  //   isLoading = true;
  //   errorMessage = null;
  //   notifyListeners();
  //   final user = await UserHelper.getUser();
  //   try {
  //     final response = await AddressRepository.instance.updateAddress(
  //       addressId: addressId ?? user?.address?.id ?? 0,
  //       id: id ?? user?.id ?? 0,
  //       governorate: governorate ?? user?.address?.governorate ?? '',
  //       city: city ?? user?.address?.city ?? '',
  //       fullAddress: fullAddress ?? user?.address?.fullAddress ?? '',
  //       token: token ?? '',
  //     );
  //     print(response.statusCode);
  //     if (response.statusCode == 200) {
  //       debugPrint('Address updated successfully');
  //     } else {
  //       errorMessage = '${response.statusCode}';
  //       debugPrint(errorMessage!);
  //     }
  //   } catch (e) {
  //     errorMessage = '$e';
  //     debugPrint(errorMessage!);
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }
}
