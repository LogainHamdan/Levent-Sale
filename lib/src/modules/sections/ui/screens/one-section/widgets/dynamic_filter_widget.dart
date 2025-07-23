import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/filter_models.dart';
import '../../../../models/filter_type.dart';
class ActiveFiltersWidget extends StatelessWidget {
  final Map<String, dynamic> selectedFilters;
  final List<DynamicFilter> availableFilters;
  final VoidCallback onClearAll;
  final Function(String) onClearFilter;

  const ActiveFiltersWidget({
    Key? key,
    required this.selectedFilters,
    required this.availableFilters,
    required this.onClearAll,
    required this.onClearFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedFilters.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الفلاتر النشطة',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: onClearAll,
                icon: Icon(Icons.clear_all, size: 16.sp),
                label: Text('مسح الكل'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red[600],
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: selectedFilters.entries.map((entry) {
              final filterId = entry.key;
              final filterValue = entry.value;
              final filter = availableFilters.firstWhere((f) => f.id == filterId);

              String displayValue = _getDisplayValue(filter, filterValue);

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${filter.label}: $displayValue',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () => onClearFilter(filterId),
                      child: Icon(
                        Icons.close,
                        size: 14.sp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getDisplayValue(DynamicFilter filter, dynamic value) {
    if (value is List) {
      return value.join(', ');
    } else if (filter.type == FilterType.dropdown) {
      final option = filter.options.firstWhere(
            (o) => o.value.toString() == value.toString(),
        orElse: () => FilterOption(id: '', name: value.toString(), value: value),
      );
      return option.name;
    } else {
      return value.toString();
    }
  }
}

// ✅ Widget للفلاتر السريعة المحسنة
class EnhancedQuickFiltersWidget extends StatelessWidget {
  final List<SubCategory> subCategories;
  final List<SubCategoryStats> subCategoriesStats;
  final dynamic selectedSubcategoryId;
  final Function(int, String) onSubcategorySelected;

  const EnhancedQuickFiltersWidget({
    Key? key,
    required this.subCategories,
    required this.subCategoriesStats,
    this.selectedSubcategoryId,
    required this.onSubcategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                'فلترة سريعة',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subCategories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // خيار "الكل"
                  return _buildFilterChip(
                    context: context,
                    label: 'الكل',
                    count: null,
                    isSelected: selectedSubcategoryId == null,
                    onTap: () => onSubcategorySelected(0, 'الكل'),
                  );
                }

                final subCategory = subCategories[index - 1];
                final stats = subCategoriesStats.firstWhere(
                      (stat) => stat.id == subCategory.id,
                  orElse: () => SubCategoryStats(
                    id: subCategory.id,
                    name: subCategory.name,
                    adsCount: subCategory.adsCount ?? 0,
                  ),
                );

                return _buildFilterChip(
                  context: context,
                  label: subCategory.name,
                  count: stats.adsCount,
                  isSelected: selectedSubcategoryId == subCategory.id,
                  onTap: () => onSubcategorySelected(subCategory.id, subCategory.name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    int? count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            if (count != null && count > 0) ...[
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.2)
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}





class SubCategory {
  final int id;
  final String name;
  final String? description;
  final int? adsCount;

  SubCategory({
    required this.id,
    required this.name,
    this.description,
    this.adsCount,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      adsCount: json['adsCount'],
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

class CategoryStats {
  final int id;
  final String name;
  final int adsCount;

  CategoryStats({
    required this.id,
    required this.name,
    required this.adsCount,
  });

  factory CategoryStats.fromJson(Map<String, dynamic> json) {
    return CategoryStats(
      id: json['id'],
      name: json['name'],
      adsCount: json['adsCount'] ?? 0,
    );
  }
}

class CategoryInfo {
  final int id;
  final String name;
  final String? description;
  final List<SubCategory> subCategories;

  CategoryInfo({
    required this.id,
    required this.name,
    this.description,
    required this.subCategories,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      subCategories: (json['subCategories'] as List? ?? [])
          .map((sub) => SubCategory.fromJson(sub))
          .toList(),
    );
  }

  factory CategoryInfo.fromJsonWithStats(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      subCategories: (json['subCategories'] as List? ?? [])
          .map((sub) => SubCategory.fromJson(sub))
          .toList(),
    );
  }
}

enum FilterType { text, number, dropdown, checkbox, range }

class FilterOption {
  final String id;
  final String name;
  final dynamic value;
  bool isSelected;
  final int? adsCount;

  FilterOption({
    required this.id,
    required this.name,
    required this.value,
    this.isSelected = false,
    this.adsCount,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      id: json['id'].toString(),
      name: json['name'],
      value: json['value'],
      isSelected: json['isSelected'] ?? false,
      adsCount: json['adsCount'],
    );
  }
}

class DynamicFilter {
  final String id;
  final String name;
  final String label;
  final FilterType type;
  final List<FilterOption> options;
  final String? description;
  dynamic selectedValue;
  List<dynamic>? selectedValues;

  DynamicFilter({
    required this.id,
    required this.name,
    required this.label,
    required this.type,
    this.options = const [],
    this.description,
    this.selectedValue,
    this.selectedValues,
  });

  factory DynamicFilter.fromJson(Map<String, dynamic> json) {
    FilterType filterType;
    switch (json['type']?.toString().toLowerCase()) {
      case 'number':
        filterType = FilterType.number;
        break;
      case 'dropdown':
        filterType = FilterType.dropdown;
        break;
      case 'checkbox':
        filterType = FilterType.checkbox;
        break;
      case 'range':
        filterType = FilterType.range;
        break;
      case 'text':
      default:
        filterType = FilterType.text;
        break;
    }

    return DynamicFilter(
      id: json['id'],
      name: json['name'],
      label: json['label'],
      type: filterType,
      options: (json['options'] as List? ?? [])
          .map((option) => FilterOption.fromJson(option))
          .toList(),
      description: json['description'],
    );
  }

  Map<String, dynamic> getSelectedFilters() {
    final filters = <String, dynamic>{};

    switch (type) {
      case FilterType.checkbox:
        final selectedOptions = options.where((o) => o.isSelected).toList();
        if (selectedOptions.isNotEmpty) {
          filters[name] = selectedOptions.map((o) => o.value).toList();
        }
        break;
      case FilterType.dropdown:
        if (selectedValue != null) {
          filters[name] = selectedValue;
        }
        break;
      case FilterType.range:
        if (selectedValues != null && selectedValues!.length == 2) {
          filters['${name}_min'] = selectedValues![0];
          filters['${name}_max'] = selectedValues![1];
        }
        break;
      case FilterType.number:
      case FilterType.text:
        if (selectedValue != null && selectedValue.toString().isNotEmpty) {
          filters[name] = selectedValue;
        }
        break;
    }

    return filters;
  }

  void reset() {
    selectedValue = null;
    selectedValues = null;
    for (var option in options) {
      option.isSelected = false;
    }
  }
}




class QuickFiltersWidget extends StatelessWidget {
  final List<SubCategory> subCategories;
  final int? selectedSubcategoryId;
  final Function(int? subcategoryId, String? subcategoryName) onSubcategorySelected;

  const QuickFiltersWidget({
    Key? key,
    required this.subCategories,
    required this.selectedSubcategoryId,
    required this.onSubcategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EnhancedQuickFiltersWidget(
      subCategories: subCategories,
      subCategoriesStats: [], // قائمة فارغة للتوافق العكسي
      selectedSubcategoryId: selectedSubcategoryId,
      onSubcategorySelected: onSubcategorySelected,
    );
  }
}