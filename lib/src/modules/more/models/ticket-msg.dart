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
    DateTime parseSentAt(dynamic sentAt) {
      if (sentAt is String) {
        return DateTime.parse(sentAt);
      } else if (sentAt is List) {
        return DateTime(
          sentAt[0],
          sentAt[1],
          sentAt[2],
          sentAt[3],
          sentAt[4],
          sentAt[5],
          (sentAt[6] / 1000000).round(),
        );
      } else {
        return DateTime.now();
      }
    }

    return TicketMessage(
      id: json['id']?.toString() ?? '',
      ticketId: json['ticketId']?.toString() ?? '',
      senderId: json['senderId'] is int
          ? json['senderId']
          : int.tryParse(json['senderId'].toString()) ?? 0,
      senderType: SenderType.values.firstWhere(
        (e) => e.toString().split('.').last == json['senderType'],
        orElse: () => SenderType.USER,
      ),
      message: json['message']?.toString() ?? '',
      sentAt: parseSentAt(json['sentAt']),
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
