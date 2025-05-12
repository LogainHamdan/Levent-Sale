import 'package:Levant_Sale/src/modules/more/models/ticket.dart';

class TicketMessage {
  final String id;
  final String ticketId;
  final int senderId;
  final SenderType senderType;
  final String message;
  final DateTime sentAt;

  TicketMessage({
    required this.id,
    required this.ticketId,
    required this.senderId,
    required this.senderType,
    required this.message,
    required this.sentAt,
  });

  factory TicketMessage.fromJson(Map<String, dynamic> json) {
    return TicketMessage(
      id: json['id'] ?? '',
      ticketId: json['ticketId'] ?? '',
      senderId: json['senderId'] ?? 0,
      senderType: SenderType.values.firstWhere(
        (e) => e.toString().split('.').last == json['senderType'],
        orElse: () => SenderType.USER,
      ),
      message: json['message'] ?? '',
      sentAt:
          DateTime.parse(json['sentAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketId': ticketId,
      'senderId': senderId,
      'senderType': senderType.toString().split('.').last,
      'message': message,
      'sentAt': sentAt.toIso8601String(),
    };
  }
}
