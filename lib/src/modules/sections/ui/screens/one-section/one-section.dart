import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/one-section/widgets/products_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/provider.dart';
import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../models/filter_models.dart';

class Section extends StatefulWidget {
  static const String id = '/section';

  const Section({super.key});

  @override
  State<Section> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<Section> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
    _initAnimations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _initAnimations() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final sectionProvider = Provider.of<SectionProvider>(context, listen: false);

        // ✅ حمّل المزيد إذا كان هناك إعلانات محملة ويمكن تحميل المزيد
        if (sectionProvider.adsByCategory.isNotEmpty &&
            sectionProvider.hasMoreData &&
            !sectionProvider.isLoadingMore) {
          final currentCategoryId = sectionProvider.navigationPath.isNotEmpty
              ? sectionProvider.navigationPath.last.id
              : null;
          if (currentCategoryId != null) {
            sectionProvider.loadMoreAds('$currentCategoryId');
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final sectionProvider = Provider.of<SectionProvider>(context, listen: false);

    final categoryId = homeProvider.selectedCategory?.id ?? 0;

    final categoryLevel = CategoryLevel(
      id: categoryId,
      name: homeProvider.selectedCategory?.name ?? 'القسم',
      level: 0,
    );

    sectionProvider.navigateToCategory(categoryLevel);
  }

  Future<void> _onRefresh() async {
    final sectionProvider = Provider.of<SectionProvider>(context, listen: false);

    if (sectionProvider.adsByCategory.isNotEmpty && sectionProvider.navigationPath.isNotEmpty) {
      final currentCategoryId = sectionProvider.navigationPath.last.id;
      await sectionProvider.refresh('$currentCategoryId');
    } else {
      // إعادة تحميل معلومات القسم الحالي
      if (sectionProvider.navigationPath.isNotEmpty) {
        final currentCategoryId = sectionProvider.navigationPath.last.id;
        await sectionProvider.fetchCategoryInfo(currentCategoryId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Consumer<SectionProvider>(
            builder: (context, sectionProvider, _) {
              return CustomScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildSubCategoriesSection(sectionProvider),

                        // ✅ عرض أدوات التحكم والفلاتر عند وجود إعلانات أو فلاتر
                        if (sectionProvider.adsByCategory.isNotEmpty || sectionProvider.availableFilters.isNotEmpty)
                          _buildViewSwitcherAndFilters(sectionProvider),
                      ],
                    ),
                  ),

                  if (sectionProvider.adsByCategory.isNotEmpty)
                    _buildProductsSection(sectionProvider)
                  else if (sectionProvider.isLoading)
                    _buildLoadingSection()
                  else if (sectionProvider.error != null)
                      SliverToBoxAdapter(child: _buildErrorWidget(sectionProvider))
                    else if (sectionProvider.adsByCategory.isEmpty && !sectionProvider.isLoading)
                        SliverToBoxAdapter(child: _buildEmptyWidget()),

                  if (sectionProvider.isLoadingMore && sectionProvider.adsByCategory.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(20.h),
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'جاري تحميل المزيد...',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Consumer<SectionProvider>(
        builder: (context, sectionProvider, _) {
          return Text(
            sectionProvider.navigationPath.isNotEmpty
                ? sectionProvider.navigationPath.last.name
                : 'القسم',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          );
        },
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16.sp),
        onPressed: () {
          final sectionProvider = Provider.of<SectionProvider>(context, listen: false);
          if (sectionProvider.canGoBack) {
            sectionProvider.navigateBack();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      actions: [

        Consumer<SectionProvider>(
          builder: (context, sectionProvider, _) {
            if (sectionProvider.availableFilters.isEmpty && sectionProvider.adsByCategory.isEmpty) {
              return SizedBox.shrink();
            }

            return Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.tune,
                    color: sectionProvider.hasSelectedFilters()
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                    size: 20.sp,
                  ),
                  onPressed: () => _showFilterBottomSheet(sectionProvider),
                ),
                if (sectionProvider.hasSelectedFilters())
                  Positioned(
                    right: 8.w,
                    top: 8.h,
                    child: Container(
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${sectionProvider.getSelectedFiltersCount()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  // ✅ تحسين _buildSubCategoriesSection - بدون زر "عرض الكل"
  Widget _buildSubCategoriesSection(SectionProvider sectionProvider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          if (sectionProvider.isLoadingCategoryInfo)
            SizedBox(
              height: 60.h,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              ),
            )
          else if (sectionProvider.categoryInfo != null &&
              sectionProvider.categoryInfo!.subCategories.isNotEmpty)
          // قائمة الأقسام الفرعية فقط
            SizedBox(
              height: 20.h,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: sectionProvider.categoryInfo!.subCategories.map((subCategory) {
                    return GestureDetector(
                      onTap: () {
                        final categoryLevel = CategoryLevel(
                          id: subCategory.id,
                          name: subCategory.name,
                          level: sectionProvider.navigationPath.length,
                        );
                        sectionProvider.navigateToCategory(categoryLevel);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 16.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              subCategory.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Theme.of(context).primaryColor,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '(${subCategory.productCount})',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          else
            SizedBox()
        ],
      ),
    );
  }

  Widget _buildViewSwitcherAndFilters(SectionProvider sectionProvider) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  _buildViewButton(
                    icon: Icons.apps,
                    isSelected: sectionProvider.viewType == ViewType.grid,
                    onTap: () => sectionProvider.setViewType(ViewType.grid),
                  ),
                  _buildViewButton(
                    icon: Icons.list,
                    isSelected: sectionProvider.viewType == ViewType.list,
                    onTap: () => sectionProvider.setViewType(ViewType.list),
                  ),
                ],
              ),
            ),

            // ✅ عرض زر الفلاتر إذا كان هناك فلاتر متاحة
            if (sectionProvider.availableFilters.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.tune,
                            color: sectionProvider.hasSelectedFilters()
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'الفلاتر',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: sectionProvider.hasSelectedFilters()
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (sectionProvider.hasSelectedFilters())
                            Container(
                              margin: EdgeInsets.only(right: 4.w),
                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                '${sectionProvider.getSelectedFiltersCount()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () => _showFilterBottomSheet(sectionProvider),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isSelected ? Colors.black : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return SliverToBoxAdapter(
      child: Container(
        height: 400.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'جاري تحميل الإعلانات...',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsSection(SectionProvider sectionProvider) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(16.w),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: Theme.of(context).primaryColor,
          child: ProductsFilterDetails(
            productList: sectionProvider.adsByCategory,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(SectionProvider sectionProvider) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red[600], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'حدث خطأ في تحميل البيانات',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              sectionProvider.error ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: _loadInitialData,
              icon: Icon(Icons.refresh),
              label: Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined, color: Colors.blue[600], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'لا توجد منتجات',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'لم يتم العثور على أي منتجات في هذا التصنيف حالياً',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.blue[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () {
                final sectionProvider = Provider.of<SectionProvider>(context, listen: false);
                sectionProvider.resetAllFilters();
                if (sectionProvider.navigationPath.isNotEmpty) {
                  final currentCategoryId = sectionProvider.navigationPath.last.id;
                  sectionProvider.fetchCategoryAds('$currentCategoryId');
                }
              },
              icon: Icon(Icons.clear_all),
              label: Text('مسح الفلاتر'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Icon(Icons.search, color: Theme.of(context).primaryColor),
                SizedBox(width: 8.w),
                Text(
                  'البحث في المنتجات',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(SectionProvider sectionProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الفلاتر',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              if (sectionProvider.hasSelectedFilters())
                                TextButton(
                                  onPressed: () {
                                    sectionProvider.resetAllFilters();
                                  },
                                  child: Text(
                                    'مسح الكل',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Icon(Icons.close, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        'اختر الفلاتر المناسبة لعرض النتائج',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.all(16.w),
                    itemCount: sectionProvider.isLoadingFilters
                        ? 3
                        : sectionProvider.availableFilters.length,
                    itemBuilder: (context, index) {
                      if (sectionProvider.isLoadingFilters) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        );
                      }

                      final filter = sectionProvider.availableFilters[index];
                      return _buildSimpleFilterItem(filter, sectionProvider);
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(top: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.grey[700],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text('إلغاء'),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () async {
                            final currentCategoryId = sectionProvider.navigationPath.isNotEmpty
                                ? sectionProvider.navigationPath.last.id
                                : null;
                            if (currentCategoryId != null) {
                              // ✅ تطبيق الفلاتر فقط
                              await sectionProvider.applyFilters('$currentCategoryId');
                            }
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text('تطبيق'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ إضافة زر إعادة تعيين لكل فلتر
  Widget _buildSimpleFilterItem(DynamicFilter filter, SectionProvider sectionProvider) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                filter.label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              // ✅ زر إعادة تعيين الفلتر
              if (_hasFilterValue(filter))
                GestureDetector(
                  onTap: () {
                    sectionProvider.resetFilter(filter.id);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.clear, size: 12.sp, color: Colors.red[600]),
                        SizedBox(width: 4.w),
                        Text(
                          'مسح',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.red[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),

          // حسب نوع الفلتر
          if (filter.type == FilterType.range)
            _buildRangeFilter(filter, sectionProvider)
          else if (filter.type == FilterType.dropdown)
            _buildDropdownFilter(filter, sectionProvider)
          else
            _buildTextFilter(filter, sectionProvider),
        ],
      ),
    );
  }

  // ✅ تحسين _buildDropdownFilter مع عرض القيمة الحالية
  Widget _buildDropdownFilter(DynamicFilter filter, SectionProvider sectionProvider) {
    return Consumer<SectionProvider>(
      builder: (context, provider, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(
                color: filter.selectedValue != null
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!
            ),
            borderRadius: BorderRadius.circular(8.r),
            color: filter.selectedValue != null
                ? Theme.of(context).primaryColor.withOpacity(0.05)
                : Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: filter.selectedValue,
              hint: Text(
                'اختر...',
                style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
              ),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: filter.selectedValue != null
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
              ),
              items: [
                DropdownMenuItem<dynamic>(
                  value: null,
                  child: Text(
                      'اختر...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      )
                  ),
                ),
                ...filter.options.map((option) {
                  return DropdownMenuItem<dynamic>(
                    value: option.value,
                    child: Text(
                        option.name,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: filter.selectedValue == option.value
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: filter.selectedValue == option.value
                              ? Theme.of(context).primaryColor
                              : Colors.black87,
                        )
                    ),
                  );
                }).toList(),
              ],
              onChanged: (value) {
                sectionProvider.updateFilter(filter.id, value);
              },
            ),
          ),
        );
      },
    );
  }

  // ✅ تحسين _buildTextFilter مع حفظ القيمة المدخلة
  Widget _buildTextFilter(DynamicFilter filter, SectionProvider sectionProvider) {
    final TextEditingController controller = TextEditingController(
        text: filter.selectedValue?.toString() ?? ''
    );

    return Consumer<SectionProvider>(
      builder: (context, provider, child) {
        return TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'أدخل النص...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: filter.selectedValue != null && filter.selectedValue!.isNotEmpty
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            fillColor: filter.selectedValue != null && filter.selectedValue!.isNotEmpty
                ? Theme.of(context).primaryColor.withOpacity(0.05)
                : Colors.white,
            filled: true,
          ),
          onChanged: (value) {
            sectionProvider.updateFilter(filter.id, value);
          },
        );
      },
    );
  }

  // ✅ تحسين _buildRangeFilter مع حفظ القيم المدخلة
  Widget _buildRangeFilter(DynamicFilter filter, SectionProvider sectionProvider) {
    final TextEditingController fromController = TextEditingController(
        text: filter.selectedValues != null && filter.selectedValues!.isNotEmpty
            ? filter.selectedValues![0]?.toString() ?? ''
            : ''
    );

    final TextEditingController toController = TextEditingController(
        text: filter.selectedValues != null && filter.selectedValues!.length > 1
            ? filter.selectedValues![1]?.toString() ?? ''
            : ''
    );

    return Consumer<SectionProvider>(
      builder: (context, provider, child) {
        bool hasValue = (filter.selectedValues != null &&
            filter.selectedValues!.any((v) => v != null && v.toString().isNotEmpty));

        return Row(
          children: [
            Expanded(
              child: TextField(
                controller: fromController,
                decoration: InputDecoration(
                  hintText: 'من',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: hasValue ? Theme.of(context).primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  fillColor: hasValue
                      ? Theme.of(context).primaryColor.withOpacity(0.05)
                      : Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final currentValues = filter.selectedValues ?? [null, null];
                  sectionProvider.updateFilter(filter.id, [value.isEmpty ? null : value, currentValues.length > 1 ? currentValues[1] : null]);
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                controller: toController,
                decoration: InputDecoration(
                  hintText: 'إلى',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: hasValue ? Theme.of(context).primaryColor : Colors.grey[300]!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  fillColor: hasValue
                      ? Theme.of(context).primaryColor.withOpacity(0.05)
                      : Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final currentValues = filter.selectedValues ?? [null, null];
                  sectionProvider.updateFilter(filter.id, [currentValues.isNotEmpty ? currentValues[0] : null, value.isEmpty ? null : value]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ✅ دالة مساعدة للتحقق من وجود قيمة في الفلتر
  bool _hasFilterValue(DynamicFilter filter) {
    switch (filter.type) {
      case FilterType.dropdown:
      case FilterType.number:
      case FilterType.text:
        return filter.selectedValue != null && filter.selectedValue.toString().isNotEmpty;
      case FilterType.range:
        return filter.selectedValues != null &&
            filter.selectedValues!.any((v) => v != null && v.toString().isNotEmpty);
      case FilterType.checkbox:
        return filter.options.any((option) => option.isSelected);
      default:
        return false;
    }
  }
}