import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryStatsWidget extends StatelessWidget {
  final List<CategoryStats> categories;
  final int? selectedCategoryId;
  final Function(int categoryId, String categoryName) onCategorySelected;

  const CategoryStatsWidget({
    super.key,
    required this.categories,
    this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تصفح حسب القسم',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategoryId == category.id;

                return GestureDetector(
                  onTap: () => onCategorySelected(category.id, category.name),
                  child: Container(
                    width: 140.w,
                    margin: EdgeInsets.only(right: 12.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300]!,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة القسم
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            _getCategoryIcon(category.name),
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),

                        // اسم القسم
                        Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),

                        // عدد الإعلانات
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.2)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${category.adsCount} إعلان',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName.toLowerCase()) {
      case 'سيارات':
      case 'المركبات':
        return Icons.directions_car;
      case 'دراجات نارية':
        return Icons.motorcycle;
      case 'مركبات متخصصة':
        return Icons.local_shipping;
      case 'عقارات':
        return Icons.home;
      case 'إلكترونيات':
        return Icons.smartphone;
      case 'أثاث':
        return Icons.chair;
      case 'ملابس':
        return Icons.checkroom;
      case 'رياضة':
        return Icons.sports_football;
      default:
        return Icons.category;
    }
  }
}

// نموذج البيانات لإحصائيات الأقسام
class CategoryStats {
  final int id;
  final String name;
  final int adsCount;
  final String? iconUrl;
  final List<SubCategoryStats>? subCategories;

  CategoryStats({
    required this.id,
    required this.name,
    required this.adsCount,
    this.iconUrl,
    this.subCategories,
  });

  factory CategoryStats.fromJson(Map<String, dynamic> json) {
    return CategoryStats(
      id: json['id'],
      name: json['name'],
      adsCount: json['adsCount'] ?? 0,
      iconUrl: json['iconUrl'],
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
          .map((sub) => SubCategoryStats.fromJson(sub))
          .toList()
          : null,
    );
  }
}

class SubCategoryStats {
  final int id;
  final String name;
  final int adsCount;

  SubCategoryStats({
    required this.id,
    required this.name,
    required this.adsCount,
  });

  factory SubCategoryStats.fromJson(Map<String, dynamic> json) {
    return SubCategoryStats(
      id: json['id'],
      name: json['name'],
      adsCount: json['adsCount'] ?? 0,
    );
  }
}

// ويدجت فرعية لعرض الأقسام الفرعية
class SubCategoriesWidget extends StatelessWidget {
  final List<SubCategoryStats> subCategories;
  final int? selectedSubCategoryId;
  final Function(int subCategoryId, String subCategoryName) onSubCategorySelected;

  const SubCategoriesWidget({
    super.key,
    required this.subCategories,
    this.selectedSubCategoryId,
    required this.onSubCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الأقسام الفرعية',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: subCategories.map((subCategory) {
              final isSelected = selectedSubCategoryId == subCategory.id;

              return GestureDetector(
                onTap: () => onSubCategorySelected(
                  subCategory.id,
                  subCategory.name,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        subCategory.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.2)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          '${subCategory.adsCount}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}