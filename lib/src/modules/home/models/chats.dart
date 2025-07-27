class ConversationListResponse {
  final List<Conversation?>? content;

  ConversationListResponse({this.content});

  factory ConversationListResponse.fromJson(Map<String, dynamic> json) {
    return ConversationListResponse(
      content: (json['content'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
    );
  }
}

class Conversation {
  final int? unreadMessages;
  final Message? lastMessage;

  final ChatProfile? chatProfile;

  Conversation({
    this.unreadMessages,
    this.lastMessage,
    this.chatProfile,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      unreadMessages: json['unreadMessages'],
      lastMessage: Message.fromJson(json['lastMessage']),
      chatProfile: ChatProfile.fromJson(json['chatProfile']),
    );
  }
}

class Message {
  final String? id;
  final int? senderId;
  final int? receiverId;
  final DateTime? sentAt;
  final String? encryptedContent;
  final String? content;
  final int? adId;
  final DateTime? readAt;

  Message({
    this.id,
    this.senderId,
    this.receiverId,
    this.sentAt,
    this.encryptedContent,
    this.content,
    this.adId,
    this.readAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    DateTime? sentAt;
    if (json['sentAt'] is List) {
      final list = json['sentAt'];
      if (list.length >= 6) {
        sentAt = DateTime(
          list[0],
          list[1],
          list[2],
          list[3],
          list[4],
          list[5],
          list.length > 6 ? list[6] ~/ 1000 : 0,
        );
      }
    }

    return Message(
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
}

class ChatProfile {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;

  ChatProfile({
    this.id,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  factory ChatProfile.fromJson(Map<String, dynamic> json) {
    return ChatProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePicture: json['profilePicture'],
    );
  }
}
