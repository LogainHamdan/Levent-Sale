class RootCategoryModel {
  final int id;
  final String name;
  final String parentCategory;
  final List<String> subCategories;
  final String description;
  final String imageUrl;
  final int productCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String categoryPath;
  final String categoryNamePath;
  final bool active;

  RootCategoryModel({
    required this.id,
    required this.name,
    required this.parentCategory,
    required this.subCategories,
    required this.description,
    required this.imageUrl,
    required this.productCount,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.categoryPath,
    required this.categoryNamePath,
    required this.active,
  });

  factory RootCategoryModel.fromJson(Map<String, dynamic> json) {
    return RootCategoryModel(
      id: json['id'],
      name: json['name'],
      parentCategory: json['parentCategory'],
      subCategories: List<String>.from(json['subCategories']),
      description: json['description'],
      imageUrl: json['imageUrl'],
      productCount: json['productCount'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isActive: json['isActive'],
      categoryPath: json['categoryPath'],
      categoryNamePath: json['categoryNamePath'],
      active: json['active'],
    );
  }
}
