class NotificationResponse {
  final List<NotificationItem> content;
  final Pageable pageable;
  final int totalElements;
  final int totalPages;
  final bool last;
  final int size;
  final int number;
  final Sort sort;
  final int numberOfElements;
  final bool first;
  final bool empty;

  NotificationResponse({
    required this.content,
    required this.pageable,
    required this.totalElements,
    required this.totalPages,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.first,
    required this.empty,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      content: (json['content'] as List)
          .map((item) => NotificationItem.fromJson(item))
          .toList(),
      pageable: Pageable.fromJson(json['pageable']),
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      last: json['last'],
      size: json['size'],
      number: json['number'],
      sort: Sort.fromJson(json['sort']),
      numberOfElements: json['numberOfElements'],
      first: json['first'],
      empty: json['empty'],
    );
  }
}

class NotificationItem {
  final String id;
  final int recipientId;
  final String type;
  final String title;
  final String body;
  final String logoUrl;
  final String imageUrl;
  final CustomData customData;
  final DateTime createdAt;
  final dynamic readAt;
  bool read;

  NotificationItem({
    required this.id,
    required this.recipientId,
    required this.type,
    required this.title,
    required this.body,
    required this.logoUrl,
    required this.imageUrl,
    required this.customData,
    required this.createdAt,
    this.readAt,
    required this.read,
  });
  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'] ?? '',
      recipientId: json['recipientId'] ?? 0,
      type: json['type'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      customData: json['customData'] != null
          ? CustomData.fromJson(json['customData'])
          : CustomData(),
      createdAt: (json['createdAt'] != null &&
              json['createdAt'] is List &&
              json['createdAt'].length >= 6)
          ? DateTime(
              json['createdAt'][0],
              json['createdAt'][1],
              json['createdAt'][2],
              json['createdAt'][3],
              json['createdAt'][4],
              json['createdAt'][5],
              (json['createdAt'].length > 6)
                  ? (json['createdAt'][6] ~/ 1000000)
                  : 0,
            )
          : DateTime.now(),
      readAt: json['readAt'] != null && json['readAt'] is List
          ? DateTime(
              json['readAt'][0],
              json['readAt'][1],
              json['readAt'][2],
              json['readAt'][3],
              json['readAt'][4],
              json['readAt'][5],
              (json['readAt'].length > 6) ? (json['readAt'][6] ~/ 1000000) : 0,
            )
          : null,
      read: json['read'] ?? false,
    );
  }
}

class CustomData {
  final String? action;
  final String? followerId;
  final String? adName;
  final String? notificationType;
  final String? status;

  CustomData({
    this.action,
    this.followerId,
    this.adName,
    this.notificationType,
    this.status,
  });

  factory CustomData.fromJson(dynamic json) {
    if (json == null || json is! Map<String, dynamic>) {
      return CustomData();
    }

    return CustomData(
      action: json['action'] as String?,
      followerId: json['followerId'] as String?,
      adName: json['adName'] as String?,
      notificationType: json['notificationType'] as String?,
      status: json['status'] as String?,
    );
  }
}

class Pageable {
  final int pageNumber;
  final int pageSize;
  final Sort sort;
  final int offset;
  final bool paged;
  final bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      sort: Sort.fromJson(json['sort']),
      offset: json['offset'],
      paged: json['paged'],
      unpaged: json['unpaged'],
    );
  }
}

class Sort {
  final bool empty;
  final bool unsorted;
  final bool sorted;

  Sort({
    required this.empty,
    required this.unsorted,
    required this.sorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json['empty'],
      unsorted: json['unsorted'],
      sorted: json['sorted'],
    );
  }
}
