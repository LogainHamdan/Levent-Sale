import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Levant_Sale/src/config/constants.dart';

class MyCollectionScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();

  final List<String> _buttons = ['مراجعة', 'تعديل', 'عرض'];
  final List<Color> _buttonColors = [
    Colors.red.withOpacity(0.2),
    kprimaryColor.withOpacity(0.2),
    amberColor.withOpacity(0.1),
  ];
  final List<Color> _buttonTextColors = [
    Colors.red,
    kprimaryColor,
    amberColor,
  ];
  final List<Widget> _buttonIcons = [
    Padding(
      padding: EdgeInsets.only(bottom: 9.0),
      child: Image.asset(
        'assets/imgs_icons/sections/assets/icons/مراجعة.png',
        height: 25.h,
      ),
    ),
    Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Icon(
          Icons.note_alt_outlined,
          color: kprimaryColor,
        )),
    Image.asset(
      'assets/imgs_icons/sections/assets/icons/عرض.png',
      height: 25.h,
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
}
