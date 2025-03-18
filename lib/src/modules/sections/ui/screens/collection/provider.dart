import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabProvider extends ChangeNotifier {
  int _currentIndex = 0;

  final List<String> _buttons = ['مراجعة', 'تعديل', 'عرض'];
  final List<Color> _buttonColors = [
    Colors.red.withOpacity(0.2),
    kprimaryColor.withOpacity(0.2),
    amberColor.withOpacity(0.2),
  ];
  final List<Color> _buttonTextColors = [
    Colors.red,
    Colors.green,
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
      child: Image.asset(
        'assets/imgs_icons/sections/assets/icons/تعديل.png',
        height: 20.h,
      ),
    ),
    Image.asset(
      'assets/imgs_icons/sections/assets/icons/عرض.png',
      height: 25.h,
    ),
  ];
  final List<Function()> _buttonActions = [
    () {},
    () {},
    () {},
  ];

  int get currentIndex => _currentIndex;

  String get buttonText => _buttons[_currentIndex];

  Color get buttonColor => _buttonColors[_currentIndex];

  Color get buttonTextColor => _buttonTextColors[_currentIndex];

  Widget get buttonIcon => _buttonIcons[_currentIndex];

  Function() get onPressed => _buttonActions[_currentIndex];

  void changeTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
