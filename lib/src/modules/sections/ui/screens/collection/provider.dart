import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/ad.dart';
import '../../../repos/ad.dart';

class MyCollectionScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();
  AdRepository repo = AdRepository();

  final List<String> _buttons = ['مراجعة', 'تعديل', 'عرض'];
  final List<Color> _buttonColors = [
    Color(0x1FF75555),
    Color(0xFF07BD74).withOpacity(0.1),
    Color(0xFFFACC15).withOpacity(0.1),
  ];
  final List<Color> _buttonTextColors = [
    Color(0xFFF75555),
    Color(0xFF07BD74),
    Color(0xFFFACC15),
  ];
  final List<Widget> _buttonIcons = [
    Padding(
      padding: EdgeInsets.only(bottom: 9.0),
      child: SvgPicture.asset(
        reviewIcon,
        height: 16.h,
        width: 16.w,
      ),
    ),
    Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: SvgPicture.asset(
          editGreenIcon,
          height: 16.h,
          width: 16.w,
        )),
    SvgPicture.asset(
      viewIcon,
      height: 16.h,
      width: 16.w,
    ),
  ];

  int get currentIndex => _currentIndex;

  String get buttonText => _buttons[_currentIndex];

  Color get buttonColor => _buttonColors[_currentIndex];

  Color get buttonTextColor => _buttonTextColors[_currentIndex];

  Widget get buttonIcon => _buttonIcons[_currentIndex];

  void changeTab(int index) {
    _currentIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<AdModel?> myAdsByStatus = [];
  bool isLoadingAds = false;

  Future<void> fetchMyAdsByStatus(
      {required String token, required String status}) async {
    isLoadingAds = true;
    notifyListeners();

    try {
      final ads = await repo.getMyAdsByStatus(token: token, status: status);
      myAdsByStatus = ads;
    } catch (e) {
      print(" Failed to fetch ads: $e");
    }

    isLoadingAds = false;
    notifyListeners();
  }
}
