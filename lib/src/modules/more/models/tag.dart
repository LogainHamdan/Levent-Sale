class TagModel {
  final String id;
  final int userId;
  final String name;

  TagModel({
    required this.id,
    required this.userId,
    required this.name,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
    );
  }
}
