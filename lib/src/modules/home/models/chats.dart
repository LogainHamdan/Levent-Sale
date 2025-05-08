class ConversationListResponse {
  final List<Conversation> content;

  ConversationListResponse({required this.content});

  factory ConversationListResponse.fromJson(Map<String, dynamic> json) {
    return ConversationListResponse(
      content: (json['content'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
    );
  }
}

class Conversation {
  final int unreadMessages;
  final Message lastMessage;
  final ChatProfile chatProfile;

  Conversation({
    required this.unreadMessages,
    required this.lastMessage,
    required this.chatProfile,
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
  final String id;
  final int senderId;
  final int receiverId;
  final DateTime sentAt;
  final String encryptedContent;
  final String content;
  final int adId;
  final DateTime? readAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.sentAt,
    required this.encryptedContent,
    required this.content,
    required this.adId,
    this.readAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    final sentAtList = json['sentAt'];
    final sentAt = DateTime(
      sentAtList[0],
      sentAtList[1],
      sentAtList[2],
      sentAtList[3],
      sentAtList[4],
      sentAtList[5],
      sentAtList[6] ~/ 1000,
    );

    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      sentAt: sentAt,
      encryptedContent: json['encryptedContent'],
      content: json['content'],
      adId: json['adId'],
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
    );
  }
}

class ChatProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String profilePicture;

  ChatProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
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
