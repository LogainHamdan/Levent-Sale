class FavoriteAd {
  final String? id;
  final int? userId;
  final String? tagId;
  final int? adId;

  FavoriteAd({
    this.id,
    this.userId,
    this.tagId,
    this.adId,
  });

  factory FavoriteAd.fromJson(Map<String, dynamic> json) {
    return FavoriteAd(
      id: json['id'] as String,
      userId: json['userId'] as int,
      tagId: json['tagId'] as String,
      adId: json['adId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tagId': tagId,
      'adId': adId,
    };
  }
}
