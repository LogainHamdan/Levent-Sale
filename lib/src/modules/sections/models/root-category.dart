class Category {
  final int id;
  final String name;
  final String? parentCategory;
  final List<String> subCategories;
  final String? description;
  final String? imageUrl;
  final int productCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String? categoryPath;
  final String? categoryNamePath;
  final bool active;
  final bool? car;

  Category({
    required this.id,
    required this.name,
    this.parentCategory,
    required this.subCategories,
    this.description,
    this.imageUrl,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.categoryPath,
    this.categoryNamePath,
    required this.active,
    this.car,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: (json['id'] as int?) ?? 0,
      name: (json['name'] as String?) ?? '',
      parentCategory: json['parentCategory']?.toString(),
      subCategories: (json['subCategories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      description: json['description']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      productCount: (json['productCount'] as int?) ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isActive: (json['isActive'] as bool?) ?? false,
      categoryPath: json['categoryPath']?.toString(),
      categoryNamePath: json['categoryNamePath']?.toString(),
      active: (json['active'] as bool?) ?? false,
      car: (json['car'] as bool?) ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentCategory': parentCategory,
      'subCategories': subCategories,
      'description': description,
      'imageUrl': imageUrl,
      'productCount': productCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
      'categoryPath': categoryPath,
      'categoryNamePath': categoryNamePath,
      'active': active,
      'car': car,
    };
  }
}
