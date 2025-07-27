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
import '../../../../sections/repos/city.dart';
import '../../../../sections/ui/screens/update-ad/provider.dart';
import '../../../../sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import '../../../models/profile.dart';
import '../../../repositories/follow-repo.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class EditProfileProvider extends ChangeNotifier {
  final EditProfileRepository repository = EditProfileRepository();
  final ImagePicker _picker = ImagePicker();
  Map<String, String?> selectedValues = {};
  City? _selectedCity;
  List<City> _cities = [];
  List<Governorate> _governorates = [];
  final Map<String, bool> _dropdownOpenedMap = {};

  final Map<String, TextEditingController> dynamicFieldControllers = {};
  Governorate? _selectedGovernorate;
  final CityRepository cityRepo = CityRepository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController businessLicenseController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController governorateController = TextEditingController();
  bool _isInit = false;

  bool isCompanyAccount = false;
  bool isLoading = false;
  String? errorMessage;
  File? _profileImage;
  File? _coverImage;
  final FollowRepository followRepository = FollowRepository();
  List<Governorate> get governorates => _governorates;

  Profile? profile;
  String? error;
  City? get selectedCity => _selectedCity;
  List<City> get cities => _cities;
  Governorate? get selectedGovernorate => _selectedGovernorate;

  File? get profileImage => _profileImage;
  bool get isInit => _isInit;

  File? get coverImage => _coverImage;
  set profileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }

  set isInit(bool value) {
    _isInit = value;
    notifyListeners();
  }

  Future<void> init(BuildContext context) async {
    final user = await UserHelper.getUser();
    final profile = await getProfile(userId: user?.id ?? 0);
    print('user ${user?.toJson()}');
    if (user != null) {
      await loadGovernorates();
      final city = profile?.address?.city;
      final gov = profile?.address?.governorate;
      print(' user: ${user.toJson()}');
      isCompanyAccount = checkIfCompanyAccount(user.roles);
      firstNameController.text = profile?.firstName ?? '';
      lastNameController.text = profile?.lastName ?? '';
      dateController.text = profile?.birthday ?? '';
      addressController.text = profile?.address?.fullAddresse ?? '';
      businessNameController.text = profile?.businessName ?? '';
      businessLicenseController.text = profile?.businessLicense ?? '';
      governorateController.text = gov?.governorateName ?? '';
      cityController.text = city?.cityName ?? '';
      setSelectedGovernorate(gov ?? Governorate());
      setSelectedCity(city ?? City());
      setSelectedValue('المحافظة', gov?.governorateName);
      setSelectedValue('المدينة', city?.cityName);
      // if (governorates.isNotEmpty) {
      //   final selectedGov = governorates.firstWhere(
      //     (gover) =>
      //         gover.governorateName ==
      //         gov?.governorateName,
      //     orElse: () => governorates.first,
      //   );
      //   setSelectedGovernorate(selectedGov);
      //
      //   if (selectedGov.id != null) {
      //     await loadCities(governorateId: selectedGov.id!);
      //   }
      // }
      //
      // if (cities.isNotEmpty &&
      //     provider.selectedAdToUpdate?.city?.cityName != null) {
      //   final selectedCity = cities.firstWhere(
      //     (cityy) =>
      //         cityy?.cityName == city?.cityName,
      //     orElse: () => cities.first,
      //   );
      //   setSelectedCity(selectedCity);
      // }
    }
    isInit = true;
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
      File fixedImage =
          await FlutterExifRotation.rotateImage(path: pickedFile.path);

      if (isProfile) {
        setProfileImage(fixedImage);
        Navigator.of(context).pop();
      } else {
        setCoverImage(fixedImage);
      }
    }
  }

  Future<void> pickCoverImage(ImageSource source,
      {bool isProfile = true}) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File fixedImage =
          await FlutterExifRotation.rotateImage(path: pickedFile.path);

      if (isProfile) {
        setProfileImage(fixedImage);
      } else {
        setCoverImage(fixedImage);
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
    final user = await UserHelper.getUser();
    print('user passed: $userId');
    try {
      final profile =
          await followRepository.getProfile(userId: userId, myid: user?.id);

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

  String? getSelectedValue(String key) {
    return selectedValues[key];
  }

  void setSelectedValue(String key, String? value) {
    selectedValues[key] = value;
    notifyListeners();
  }

  void setSelectedCity(City city) {
    _selectedCity = city;
    notifyListeners();
  }

  void resetCity() {
    _selectedCity = null;
    _cities.clear();
    selectedValues.remove("city");

    dynamicFieldControllers.remove("city")?.clear();

    notifyListeners();
  }

  void setSelectedGovernorate(Governorate governorate) {
    _selectedGovernorate = governorate;
    notifyListeners();
  }

  Future<void> loadGovernorates() async {
    isLoading = true;
    notifyListeners();

    try {
      _governorates = await cityRepo.getGovernorates();
    } catch (e) {
      print('Error loading governorates: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCities({required int governorateId}) async {
    isLoading = true;
    notifyListeners();

    try {
      _cities = await cityRepo.getCities(governorateId: governorateId);
      notifyListeners();

      print('current cities: $_cities');
    } catch (e) {
      print('Error loading cities: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Governorate?> getGovernorateById({required String id}) async {
    isLoading = true;
    notifyListeners();

    try {
      final gov = await cityRepo.getGovernorateById(id: id);
      notifyListeners();
      return gov;
    } catch (e) {
      print('Error loading gov: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<City?> getCityById({required String id}) async {
    isLoading = true;
    notifyListeners();

    try {
      final city = await cityRepo.getCityById(id: id);
      notifyListeners();
      return city;
    } catch (e) {
      print('Error loading city: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return null;
  }

  bool isDropdownOpened(String key) => _dropdownOpenedMap[key] ?? false;

  void setDropdownOpened(String key, bool value) {
    _dropdownOpenedMap[key] = value;
    notifyListeners();
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
