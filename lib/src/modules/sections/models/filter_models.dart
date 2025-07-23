// ===== MODELS =====

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ===== FilterOption Model =====
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
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      value: json['value'],
      isSelected: json['isSelected'] ?? false,
      adsCount: json['adsCount'] != null ? int.tryParse(json['adsCount'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'isSelected': isSelected,
      if (adsCount != null) 'adsCount': adsCount,
    };
  }

  @override
  String toString() {
    return 'FilterOption{id: $id, name: $name, value: $value, isSelected: $isSelected, adsCount: $adsCount}';
  }
}

// ===== DynamicFilter Model =====
class DynamicFilter {
  final String id;
  final String name;
  final String label;
  final FilterType type;
  final List<FilterOption> options;
  final String? description;
  dynamic selectedValue;
  List<dynamic> selectedValues;
  final dynamic minValue;
  final dynamic maxValue;

  DynamicFilter({
    required this.id,
    required this.name,
    required this.label,
    required this.type,
    this.options = const [],
    this.description,
    this.selectedValue,
    this.selectedValues = const [],
    this.minValue,
    this.maxValue,
  });

  factory DynamicFilter.fromJson(Map<String, dynamic> json) {
    return DynamicFilter(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      label: json['label'] ?? json['name'] ?? '',
      type: FilterType.values.firstWhere(
            (e) => e.toString().split('.').last == json['type'],
        orElse: () => FilterType.text,
      ),
      options: json['options'] != null
          ? (json['options'] as List)
          .map((option) => FilterOption.fromJson(option))
          .toList()
          : [],
      description: json['description'],
      selectedValue: json['selectedValue'],
      selectedValues: json['selectedValues'] != null
          ? List.from(json['selectedValues'])
          : [],
      minValue: json['minValue'],
      maxValue: json['maxValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'label': label,
      'type': type.toString().split('.').last,
      'options': options.map((option) => option.toJson()).toList(),
      'description': description,
      'selectedValue': selectedValue,
      'selectedValues': selectedValues,
      'minValue': minValue,
      'maxValue': maxValue,
    };
  }

  Map<String, dynamic> getSelectedFilters() {
    final filters = <String, dynamic>{};

    switch (type) {
      case FilterType.checkbox:
        final selectedOptions = options.where((option) => option.isSelected).toList();
        if (selectedOptions.isNotEmpty) {
          filters[name] = selectedOptions.map((option) => option.value).toList();
        }
        break;
      case FilterType.dropdown:
        if (selectedValue != null) {
          filters[name] = selectedValue;
        }
        break;
      case FilterType.number:
      case FilterType.text:
        if (selectedValue != null) {
          filters[name] = selectedValue;
        }
        break;
      case FilterType.range:
        if (selectedValues.isNotEmpty && selectedValues.length == 2) {
          filters['${name}_min'] = selectedValues[0];
          filters['${name}_max'] = selectedValues[1];
        }
        break;
    }

    return filters;
  }

  void reset() {
    selectedValue = null;
    selectedValues = [];
    for (var option in options) {
      option.isSelected = false;
    }
  }
}

// ===== FilterType Enum =====
enum FilterType {
  text,
  number,
  dropdown,
  checkbox,
  range,
}



// ===== SubCategoryStats Model =====


// ===== CategoryInfo Model =====
class CategoryInfo {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? productCount;
  final List<SubCategory> subCategories;
  final int? totalAds;

  CategoryInfo({
    required this.id,
    required this.name,
    this.productCount,
    this.description,
    this.imageUrl,
    required this.subCategories,
    this.totalAds,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      productCount:json['productCount'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
          .map((sub) => SubCategory.fromJson(sub))
          .toList()
          : [],
      totalAds: json['totalAds'] != null ? int.tryParse(json['totalAds'].toString()) : null,
    );
  }

  factory CategoryInfo.fromJsonWithStats(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
          .map((sub) => SubCategory.fromJsonWithStats(sub))
          .toList()
          : [],
      totalAds: json['totalAds'] != null ? int.tryParse(json['totalAds'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'productCount':productCount,
      'imageUrl': imageUrl,
      'subCategories': subCategories.map((sub) => sub.toJson()).toList(),
      if (totalAds != null) 'totalAds': totalAds,
    };
  }
}

// ===== SubCategory Model =====
class SubCategory {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int? adsCount;
  final int? productCount;

  SubCategory({
    required this.id,
    required this.name,
    this.description,
    this.productCount,
    this.imageUrl,
    this.adsCount,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      productCount:json['productCount'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      adsCount: json['adsCount'] != null ? int.tryParse(json['adsCount'].toString()) : null,
    );
  }

  factory SubCategory.fromJsonWithStats(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      productCount:json['productCount'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      adsCount: json['adsCount'] != null ? int.tryParse(json['adsCount'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      if (adsCount != null) 'adsCount': adsCount,
    };
  }

  @override
  String toString() {
    return 'SubCategory{id: $id, name: $name, adsCount: $adsCount}';
  }
}

// ===== CATEGORY STATS WIDGET =====
