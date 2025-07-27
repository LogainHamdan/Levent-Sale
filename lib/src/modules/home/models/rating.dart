class Rating {
  final String? id;
  final int? adId;
  final int? userId;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;

  Rating({
    this.id,
    this.adId,
    this.userId,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    final createdAtRaw = json['createdAt'];

    DateTime? createdAtDate;

    if (createdAtRaw is String) {
      createdAtDate = DateTime.tryParse(createdAtRaw);
    } else if (createdAtRaw is List<dynamic>) {
      createdAtDate = DateTime(
        createdAtRaw[0] ?? 0,
        createdAtRaw[1] ?? 1,
        createdAtRaw[2] ?? 1,
        createdAtRaw.length > 3 ? createdAtRaw[3] ?? 0 : 0,
        createdAtRaw.length > 4 ? createdAtRaw[4] ?? 0 : 0,
        createdAtRaw.length > 5 ? createdAtRaw[5] ?? 0 : 0,
        createdAtRaw.length > 6 ? createdAtRaw[6] ?? 0 : 0,
      );
    } else {
      createdAtDate = null;
    }

    return Rating(
      id: json['id'] as String?,
      adId: json['adId'] as int?,
      userId: json['userId'] as int?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: createdAtDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adId': adId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class RatingRequest {
  final int? adId;
  final int? userId;
  final int rating;
  final String? comment;

  RatingRequest({
    this.adId,
    this.userId,
    required this.rating,
    this.comment,
  });

  factory RatingRequest.fromJson(Map<String, dynamic> json) {
    return RatingRequest(
      adId: json['adId'] as int,
      userId: json['userId'] as int,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adId': adId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
    };
  }
}
