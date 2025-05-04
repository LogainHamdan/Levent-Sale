class FollowCount {
  final int followersCount;
  final int followingCount;

  FollowCount({
    required this.followersCount,
    required this.followingCount,
  });

  factory FollowCount.fromJson(Map<String, dynamic> json) {
    return FollowCount(
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
    );
  }
}
