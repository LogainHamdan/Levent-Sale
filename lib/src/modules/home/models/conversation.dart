class ChatMessageResponse {
  final List<ChatMessage?>? content;
  final Pageable? pageable;

  ChatMessageResponse({
    this.content,
    this.pageable,
  });

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageResponse(
      content: (json['content'] as List)
          .map((item) => ChatMessage.fromJson(item))
          .toList(),
      pageable: Pageable.fromJson(json['pageable']),
    );
  }
}

class ChatMessage {
  final String? id;
  final int? senderId;
  final int? receiverId;
  final DateTime? sentAt;
  final String? encryptedContent;
  final String? content;
  final int? adId;
  final DateTime? readAt;

  ChatMessage({
    this.id,
    this.senderId,
    this.receiverId,
    this.sentAt,
    this.encryptedContent,
    this.content,
    this.adId,
    this.readAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    DateTime? sentAt;
    if (json['sentAt'] is List) {
      final List sentAtList = json['sentAt'];
      sentAt = DateTime(
        sentAtList[0],
        sentAtList[1],
        sentAtList[2],
        sentAtList[3],
        sentAtList[4],
        sentAtList[5],
        sentAtList[6] ~/ 1000,
      );
    } else if (json['sentAt'] is String) {
      sentAt = DateTime.tryParse(json['sentAt']);
    }

    return ChatMessage(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      sentAt: sentAt,
      encryptedContent: json['encryptedContent'],
      content: json['content'],
      adId: json['adId'],
      readAt: json['readAt'] != null ? DateTime.tryParse(json['readAt']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'sentAt': sentAt?.toIso8601String(),
      'encryptedContent': encryptedContent,
      'content': content,
      'adId': adId,
      'readAt': readAt?.toIso8601String(),
    };
  }
}

class Pageable {
  final int? pageNumber;
  final int? pageSize;
  final Sort? sort;

  Pageable({
    this.pageNumber,
    this.pageSize,
    this.sort,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    return Pageable(
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      sort: Sort.fromJson(json['sort']),
    );
  }
}

class Sort {
  final bool? empty;
  final bool? sorted;
  final bool? unsorted;

  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) {
    return Sort(
      empty: json['empty'],
      sorted: json['sorted'],
      unsorted: json['unsorted'],
    );
  }
}
