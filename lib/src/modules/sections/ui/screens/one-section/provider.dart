import 'package:flutter/material.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad_model.dart';
import '../../../models/filter_models.dart';
import '../../../models/filter_type.dart';
import '../../../repos/ad.dart';

enum ViewType { grid, list }

class SectionProvider extends ChangeNotifier {
  final AdRepository _repo = AdRepository();

  // Data
  List<AdModel> _adsByCategory = [];
  CategoryInfo? _categoryInfo;
  List<DynamicFilter> _availableFilters = [];
  int _totalAdsInCategory = 0;
  List<CategoryLevel> _navigationPath = [];
  bool _isLeafCategory = false;

  // State
  bool _isLoading = false;
  bool _isLoadingCategoryInfo = false;
  bool _isLoadingFilters = false;
  bool _isLoadingStats = false;
  String? _error;
  ViewType _viewType = ViewType.grid;

  // Pagination
  int _currentPage = 0;
  int _pageSize = 20;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;

  // Getters
  List<AdModel> get adsByCategory => _adsByCategory;
  CategoryInfo? get categoryInfo => _categoryInfo;
  List<SubCategory> get subCategories => _categoryInfo?.subCategories ?? [];
  List<DynamicFilter> get availableFilters => _availableFilters;
  int get totalAdsInCategory => _totalAdsInCategory;

  // ✅ Getters للتنقل الهرمي
  List<CategoryLevel> get navigationPath => _navigationPath;
  bool get isLeafCategory => _isLeafCategory;
  bool get canGoBack => _navigationPath.length > 1;
  String get breadcrumb => _navigationPath.map((c) => c.name).join(' > ');
  bool get shouldShowFilters => _isLeafCategory;

  bool get isLoading => _isLoading;
  bool get isLoadingCategoryInfo => _isLoadingCategoryInfo;
  bool get isLoadingFilters => _isLoadingFilters;
  bool get isLoadingStats => _isLoadingStats;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;
  String? get error => _error;
  ViewType get viewType => _viewType;
  int get totalAdsCount => _adsByCategory.length;

  Map<String, dynamic> get selectedFilters {
    final filters = <String, dynamic>{};
    for (var filter in _availableFilters) {
      final filterValue = filter.getSelectedFilters();
      filters.addAll(filterValue);
    }
    return filters;
  }

  void setViewType(ViewType type) {
    _viewType = type;
    notifyListeners();
  }

  // ✅ منطق التنقل الهرمي المحدث - مع تحميل الإعلانات تلقائياً
  Future<void> navigateToCategory(CategoryLevel category) async {
    print('🧭 Navigating to category: ${category.name} (ID: ${category.id})');

    _navigationPath.add(category);
    _clearDataForNavigation();
    notifyListeners();

    try {
      // جلب معلومات القسم أولاً
      await fetchCategoryInfo(category.id);

      // تحديد ما إذا كان هذا آخر مستوى
      await _determineIfLeafCategory(category.id);

      // ✅ تحميل الفلاتر دائماً
      await fetchCategoryFilters(category.id);

      // ✅ تحميل الإعلانات تلقائياً لجميع الأقسام
      print('✅ Loading ads automatically for category: ${category.id}');
      await fetchCategoryAds('${category.id}');

    } catch (e) {
      print('❌ Error navigating to category: $e');
      _error = 'خطأ في تحميل بيانات القسم';
      notifyListeners();
    }
  }

  Future<void> navigateBack() async {
    if (canGoBack) {
      print('🔙 Navigating back from: ${_navigationPath.last.name}');

      _navigationPath.removeLast();
      _clearDataForNavigation();
      notifyListeners();

      if (_navigationPath.isNotEmpty) {
        final currentCategory = _navigationPath.last;

        try {
          await fetchCategoryInfo(currentCategory.id);
          await _determineIfLeafCategory(currentCategory.id);

          // ✅ تحميل الفلاتر والإعلانات تلقائياً عند العودة
          await fetchCategoryFilters(currentCategory.id);
          await fetchCategoryAds('${currentCategory.id}');

        } catch (e) {
          print('❌ Error navigating back: $e');
          _error = 'خطأ في العودة للقسم السابق';
          notifyListeners();
        }
      }
    }
  }

  void navigateToRoot() {
    print('🏠 Navigating to root');
    _navigationPath.clear();
    _isLeafCategory = false;
    clearData();
    notifyListeners();
  }

  // ✅ تحديد ما إذا كان القسم آخر مستوى - تعديل مُحسن
  Future<void> _determineIfLeafCategory(int categoryId) async {
    try {
      // ✅ القسم يعتبر آخر مستوى فقط إذا لم يكن له أقسام فرعية
      bool hasSubCategories = _categoryInfo?.subCategories.isNotEmpty ?? false;

      // ✅ لا نعتبر وجود الفلاتر كدليل على كونه آخر مستوى
      _isLeafCategory = !hasSubCategories;

      print('🔍 Category $categoryId - hasSubCategories: $hasSubCategories, isLeaf: $_isLeafCategory');

    } catch (e) {
      // إذا فشل في جلب معلومات القسم، تحقق من الأقسام الفرعية فقط
      _isLeafCategory = _categoryInfo?.subCategories.isEmpty ?? true;
      print('⚠️ Error determining leaf category for $categoryId, using subcategories check: $_isLeafCategory');
    }
  }

  // ✅ مسح البيانات عند التنقل
  void _clearDataForNavigation() {
    _adsByCategory = [];
    _availableFilters = [];
    _totalAdsInCategory = 0;
    _error = null;
    _currentPage = 0;
    _hasMoreData = true;
  }

  Future<void> fetchCategoryInfo(int categoryId) async {
    print('📊 fetchCategoryInfo called for categoryId: $categoryId');
    _setLoadingCategoryInfo(true);

    try {
      final token = await TokenHelper.getToken();
      print('🔑 Token obtained: ${token != null ? "✅" : "❌"}');

      final response = await _repo.getCategoryChildrenWithStats(
        categoryId: categoryId,
        token: token,
      );

      print('📊 Response received: ${response.statusCode}');

      if (response.data != null) {
        print('📊 Response data: ${response.data}');

        _categoryInfo = _repo.parseCategoryInfoWithStats(response.data);

        if (_categoryInfo != null) {
          print('✅ Category info parsed: ${_categoryInfo!.name}');
          print('✅ Subcategories count: ${_categoryInfo!.subCategories.length}');
          for (var sub in _categoryInfo!.subCategories) {
            print('  - ${sub.name} (ID: ${sub.id})');
          }
        } else {
          print('❌ Failed to parse category info');
        }

      } else {
        print('❌ Empty response data');
        _categoryInfo = null;
      }

    } catch (e) {
      print('❌ Error fetching category info: $e');
      _categoryInfo = null;
      _error = 'خطأ في جلب معلومات القسم';
    } finally {
      _setLoadingCategoryInfo(false);
    }
  }

  // ✅ جلب فلاتر القسم - محدث لجميع الأقسام
  Future<void> fetchCategoryFilters(int categoryId) async {
    _setLoadingFilters(true);

    try {
      final token = await TokenHelper.getToken();
      final response = await _repo.getCategoryFilters(
        categoryId: categoryId,
        token: token,
      );

      print('📊 Filters response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        _availableFilters = _repo.parseFilters(response.data);
        print('✅ Parsed ${_availableFilters.length} filters');

        // Debug: list all parsed filters
        for (var filter in _availableFilters) {
          print('  - ${filter.label} (${filter.type}) - ${filter.options.length} options');
        }

        // ✅ أضف فلتر الأقسام الفرعية إذا كان موجود
        if (_categoryInfo != null && _categoryInfo!.subCategories.isNotEmpty) {
          _addSubcategoryFilter();
        }
      } else if (response.statusCode == 404) {
        print('⚠️ No filters available for category $categoryId (404)');
        _availableFilters = [];

        // إضافة فلتر الأقسام الفرعية فقط إذا كان موجود
        if (_categoryInfo != null && _categoryInfo!.subCategories.isNotEmpty) {
          _addSubcategoryFilter();
        }
      } else {
        print('⚠️ Unexpected response: ${response.statusCode}');
        _availableFilters = [];
      }

    } catch (e) {
      print('❌ Error fetching filters: $e');
      _availableFilters = [];

      // Fallback: create basic subcategory filter if we have category info
      if (_categoryInfo != null && _categoryInfo!.subCategories.isNotEmpty) {
        print('🔄 Creating fallback subcategory filter');
        _addSubcategoryFilter();
      }
    } finally {
      _setLoadingFilters(false);
    }
  }

  void _addSubcategoryFilter() {
    print('🔧 _addSubcategoryFilter called');

    final existingFilter = _availableFilters.where((f) => f.id == 'subcategory').firstOrNull;

    if (existingFilter == null && _categoryInfo != null && _categoryInfo!.subCategories.isNotEmpty) {
      print('🔧 Creating subcategory filter with ${_categoryInfo!.subCategories.length} options');

      final options = _categoryInfo!.subCategories.map((sub) {
        return FilterOption(
          id: sub.id.toString(),
          name: sub.name,
          value: sub.id,
        );
      }).toList();

      final subcategoryFilter = DynamicFilter(
        id: 'subcategory',
        name: 'subcategory_id',
        label: 'التصنيف الفرعي',
        type: FilterType.dropdown,
        options: options,
      );

      _availableFilters.insert(0, subcategoryFilter);
      print('✅ Subcategory filter added successfully');
      print('✅ Total filters now: ${_availableFilters.length}');
    }
  }

  // ✅ تحديث fetchCategoryAds لتحميل الإعلانات لجميع الأقسام
  Future<void> fetchCategoryAds(
      String categoryId, {
        bool isRefresh = false,
        bool loadMore = false,
      }) async {

    if (loadMore && !_hasMoreData) return;
    if (loadMore && _isLoadingMore) return;

    if (loadMore) {
      _setLoadingMore(true);
    } else {
      if (!isRefresh) _setLoading(true);
      _currentPage = 0;
      _hasMoreData = true;
    }

    _error = null;

    try {
      final token = await TokenHelper.getToken();
      final page = loadMore ? _currentPage + 1 : 0;

      final response = await _repo.searchAdsByCategory(
        categoryId: categoryId,
        selectedFilters: selectedFilters,
        token: token,
        page: page,
        size: _pageSize,
      );

      await _processAdsResponse(response, loadMore, page);
      await updateAdsCount(categoryId);

    } catch (e) {
      _handleError(e);
      if (!loadMore) _adsByCategory = [];
    } finally {
      if (loadMore) {
        _setLoadingMore(false);
      } else {
        if (!isRefresh) _setLoading(false);
      }
    }
  }

  Future<void> updateAdsCount(String categoryId) async {
    try {
      final token = await TokenHelper.getToken();
      _totalAdsInCategory = await _repo.getAdsCountForCategory(
        categoryId: categoryId,
        filters: selectedFilters,
        token: token,
      );

      print('✅ Updated ads count: $_totalAdsInCategory ads');
      notifyListeners();
    } catch (e) {
      print('❌ Error updating ads count: $e');
    }
  }

  // ✅ تحديث updateFilter لضمان التحديث الفوري
  void updateFilter(String filterId, dynamic value, {bool isMultiple = false}) {
    print('🔧 updateFilter called: filterId=$filterId, value=$value, isMultiple=$isMultiple');

    final filterIndex = _availableFilters.indexWhere((f) => f.id == filterId);
    if (filterIndex == -1) {
      print('❌ Filter not found: $filterId');
      print('📋 Available filters: ${_availableFilters.map((f) => '${f.id} (${f.label})').toList()}');
      return;
    }

    final filter = _availableFilters[filterIndex];
    print('✅ Found filter: ${filter.label} (${filter.type})');

    switch (filter.type) {
      case FilterType.checkbox:
        if (isMultiple) {
          final optionIndex = filter.options.indexWhere((o) => o.value == value);
          if (optionIndex != -1) {
            filter.options[optionIndex].isSelected = !filter.options[optionIndex].isSelected;
            print('🔧 Checkbox option updated: ${filter.options[optionIndex].name} = ${filter.options[optionIndex].isSelected}');
          }
        } else {
          for (var option in filter.options) {
            option.isSelected = value as bool;
          }
          print('🔧 All checkbox options set to: $value');
        }
        break;
      case FilterType.dropdown:
        filter.selectedValue = value;
        print('🔧 Dropdown updated: selectedValue = $value');
        break;
      case FilterType.number:
        filter.selectedValue = value;
        print('🔧 Number updated: selectedValue = $value');
        break;
      case FilterType.range:
        if (value is List && value.length == 2) {
          filter.selectedValues = List.from(value);
          print('🔧 Range updated: selectedValues = $value');
        }
        break;
      case FilterType.text:
        filter.selectedValue = value?.toString();
        print('🔧 Text updated: selectedValue = $value');
        break;
    }

    // Debug: show current selected filters
    final currentFilters = selectedFilters;
    print('🔧 Current selected filters: $currentFilters');

    // ✅ تحديث فوري للواجهة
    notifyListeners();
    print('🔧 notifyListeners() called');
  }

  void resetAllFilters() {
    for (var filter in _availableFilters) {
      filter.reset();
    }
    notifyListeners();
  }

  void resetFilter(String filterId) {
    final filterIndex = _availableFilters.indexWhere((f) => f.id == filterId);
    if (filterIndex != -1) {
      _availableFilters[filterIndex].reset();
      notifyListeners();
    }
  }

  // ✅ تحديث applyFilters
  Future<void> applyFilters(String categoryId) async {
    print('🔧 Applying filters for category: $categoryId');
    print('🔧 Current filters: $selectedFilters');

    await fetchCategoryAds(categoryId);
  }

  // ✅ تحديث loadInitialData - مع تحميل الإعلانات تلقائياً
  Future<void> loadInitialData(int categoryId) async {
    if (_navigationPath.isEmpty || _navigationPath.last.id != categoryId) {
      final categoryLevel = CategoryLevel(
        id: categoryId,
        name: 'القسم $categoryId',
        level: _navigationPath.length,
      );
      await navigateToCategory(categoryLevel);
    } else {
      await fetchCategoryInfo(categoryId);
      await _determineIfLeafCategory(categoryId);

      // ✅ تحميل الفلاتر والإعلانات تلقائياً
      await fetchCategoryFilters(categoryId);
      await fetchCategoryAds('$categoryId');
    }
  }

  Future<void> _processAdsResponse(response, bool loadMore, int page) async {
    final responseData = response.data;

    if (responseData != null && responseData is Map<String, dynamic>) {
      final content = responseData['content'];
      final totalPages = responseData['totalPages'] ?? 0;
      final totalElements = responseData['totalElements'] ?? 0;

      _totalAdsInCategory = totalElements;

      if (content != null && content is List) {
        final newAds = content.map((json) {
          try {
            return AdModel.fromJson(json as Map<String, dynamic>);
          } catch (e) {
            return null;
          }
        }).where((ad) => ad != null).cast<AdModel>().toList();

        if (loadMore) {
          _adsByCategory.addAll(newAds);
          _currentPage = page;
        } else {
          _adsByCategory = newAds;
          _currentPage = 0;
        }

        _hasMoreData = (page + 1) < totalPages;
      } else {
        if (!loadMore) _adsByCategory = [];
        _hasMoreData = false;
      }
    } else {
      if (!loadMore) _adsByCategory = [];
      _hasMoreData = false;
    }
  }

  Future<void> loadMoreAds(String categoryId) async {
    await fetchCategoryAds(categoryId, loadMore: true);
  }

  Future<void> refresh(String categoryId) async {
    await fetchCategoryAds(categoryId, isRefresh: true);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setLoadingCategoryInfo(bool loading) {
    _isLoadingCategoryInfo = loading;
    notifyListeners();
  }

  void _setLoadingFilters(bool loading) {
    _isLoadingFilters = loading;
    notifyListeners();
  }

  void _setLoadingStats(bool loading) {
    _isLoadingStats = loading;
    notifyListeners();
  }

  void _setLoadingMore(bool loading) {
    _isLoadingMore = loading;
    notifyListeners();
  }

  void _handleError(dynamic error) {
    if (error.toString().contains('SocketException')) {
      _error = 'تحقق من اتصال الإنترنت';
    } else if (error.toString().contains('TimeoutException')) {
      _error = 'انتهت مهلة الاتصال، يرجى المحاولة مرة أخرى';
    } else if (error.toString().contains('401')) {
      _error = 'انتهت صلاحية جلسة المستخدم';
    } else if (error.toString().contains('404')) {
      _error = 'لم يتم العثور على البيانات المطلوبة';
    } else if (error.toString().contains('500')) {
      _error = 'خطأ في الخادم، يرجى المحاولة لاحقاً';
    } else {
      _error = 'حدث خطأ غير متوقع';
    }
    notifyListeners();
  }

  void clearData() {
    _adsByCategory = [];
    _categoryInfo = null;
    _availableFilters = [];
    _totalAdsInCategory = 0;
    _error = null;
    _viewType = ViewType.grid;
    _currentPage = 0;
    _hasMoreData = true;
    _isLeafCategory = false;
    notifyListeners();
  }

  DynamicFilter? getFilter(String filterId) {
    try {
      return _availableFilters.firstWhere((f) => f.id == filterId);
    } catch (e) {
      return null;
    }
  }

  bool hasSelectedFilters() {
    return selectedFilters.isNotEmpty;
  }

  int getSelectedFiltersCount() {
    return selectedFilters.keys.length;
  }
}

class CategoryLevel {
  final int id;
  final String name;
  final String? description;
  final List<CategoryLevel> children;
  final bool hasFilters;
  final int level;

  CategoryLevel({
    required this.id,
    required this.name,
    this.description,
    this.children = const [],
    this.hasFilters = false,
    this.level = 0,
  });

  bool get isLeafCategory => children.isEmpty || hasFilters;

  factory CategoryLevel.fromJson(Map<String, dynamic> json, int level) {
    return CategoryLevel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      children: json['children'] != null
          ? (json['children'] as List)
          .map((child) => CategoryLevel.fromJson(child, level + 1))
          .toList()
          : [],
      hasFilters: json['hasFilters'] ?? false,
      level: level,
    );
  }
}