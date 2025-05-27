class NotificationStats {
  final int recipientId;
  final int totalNotifications;
  final int readNotifications;
  final int unreadNotifications;

  NotificationStats({
    required this.recipientId,
    required this.totalNotifications,
    required this.readNotifications,
    required this.unreadNotifications,
  });

  factory NotificationStats.fromJson(Map<String, dynamic> json) {
    return NotificationStats(
      recipientId: json['recipientId'] ?? 0,
      totalNotifications: json['totalNotifications'] ?? 0,
      readNotifications: json['readNotifications'] ?? 0,
      unreadNotifications: json['unreadNotifications'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipientId,
      'totalNotifications': totalNotifications,
      'readNotifications': readNotifications,
      'unreadNotifications': unreadNotifications,
    };
  }
}
