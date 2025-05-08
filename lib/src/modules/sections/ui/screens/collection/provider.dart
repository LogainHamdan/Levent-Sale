import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/ad.dart';
import '../../../repos/ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/ad.dart';
import '../../../repos/ad.dart';

class MyCollectionScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController pageController = PageController();
  final AdRepository repo = AdRepository();

  // Tab configuration
  final List<String> _tabTitles = ['مراجعة', 'تعديل', 'عرض'];
  final List<Color> _tabColors = [
    Color(0x1FF75555),
    Color(0xFF07BD74).withOpacity(0.1),
    Color(0xFFFACC15).withOpacity(0.1),
  ];
  final List<Color> _tabTextColors = [
    Color(0xFFF75555),
    Color(0xFF07BD74),
    Color(0xFFFACC15),
  ];
  final List<Widget> _tabIcons = [
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
      ),
    ),
    SvgPicture.asset(
      viewIcon,
      height: 16.h,
      width: 16.w,
    ),
  ];

  List<AdModel> _rejectedAds = [];
  List<AdModel> _pendingAds = [];
  List<AdModel> _publishedAds = [];

  bool _isLoadingRejected = false;
  bool _isLoadingPending = false;
  bool _isLoadingPublished = false;

  // Getters
  int get currentIndex => _currentIndex;
  String get currentTabTitle => _tabTitles[_currentIndex];
  Color get currentTabColor => _tabColors[_currentIndex];
  Color get currentTabTextColor => _tabTextColors[_currentIndex];
  Widget get currentTabIcon => _tabIcons[_currentIndex];

  List<AdModel> get rejectedAds => _rejectedAds;
  List<AdModel> get pendingAds => _pendingAds;
  List<AdModel> get publishedAds => _publishedAds;

  bool get isLoadingRejected => _isLoadingRejected;
  bool get isLoadingPending => _isLoadingPending;
  bool get isLoadingPublished => _isLoadingPublished;

  void changeTab(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchRejectedAds() async {
    _isLoadingRejected = true;
    final token = await TokenHelper.getToken();

    try {
      final ads =
          await repo.getMyAdsByStatus(token: token ?? '', status: 'REJECTED');
      _rejectedAds = ads.whereType<AdModel>().toList();
    } catch (e) {
      debugPrint("Failed to fetch rejected ads: $e");
      _rejectedAds = [];
    } finally {
      _isLoadingRejected = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingAds() async {
    _isLoadingPending = true;
    final token = await TokenHelper.getToken();

    try {
      final ads =
          await repo.getMyAdsByStatus(token: token ?? '', status: 'PENDING');
      _pendingAds = ads.whereType<AdModel>().toList();
    } catch (e) {
      debugPrint("Failed to fetch pending ads: $e");
      _pendingAds = [];
    } finally {
      _isLoadingPending = false;
      notifyListeners();
    }
  }

  Future<void> fetchPublishedAds() async {
    _isLoadingPublished = true;
    final token = await TokenHelper.getToken();

    try {
      final ads =
          await repo.getMyAdsByStatus(token: token ?? '', status: 'PUBLISHED');
      _publishedAds = ads.whereType<AdModel>().toList();
    } catch (e) {
      debugPrint("Failed to fetch published ads: $e");
      _publishedAds = [];
    } finally {
      _isLoadingPublished = false;
      notifyListeners();
    }
  }

  List<AdModel> get currentAds {
    switch (_currentIndex) {
      case 0:
        return _rejectedAds;
      case 1:
        return _pendingAds;
      case 2:
        return _publishedAds;
      default:
        return [];
    }
  }

  bool get currentTabLoading {
    switch (_currentIndex) {
      case 0:
        return _isLoadingRejected;
      case 1:
        return _isLoadingPending;
      case 2:
        return _isLoadingPublished;
      default:
        return false;
    }
  }
}
