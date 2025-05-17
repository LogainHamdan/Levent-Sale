enum TicketStatus {
  OPEN,
  IN_PROGRESS,
  WAITING_CUSTOMER,
  CUSTOMER_REPLIED,
  CLOSED
}

enum SenderType { USER, ADMIN }

class Ticket {
  final String id;
  final int userId;
  final String title;
  final TicketStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Ticket({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    final ticketJson =
        json['ticket'] ?? json; // Use the nested ticket map if available

    String safeString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      if (value is List) return value.isNotEmpty ? value.first.toString() : '';
      return value.toString();
    }

    DateTime safeParseDate(dynamic value) {
      try {
        if (value == null) return DateTime.now();

        if (value is String) {
          return DateTime.parse(value);
        }

        if (value is List && value.length == 7) {
          int year = value[0];
          int month = value[1];
          int day = value[2];
          int hour = value[3];
          int minute = value[4];
          int second = value[5];
          int microsecond = value[6] ~/ 1000;
          return DateTime(year, month, day, hour, minute, second, microsecond);
        }

        return DateTime.now();
      } catch (e) {
        return DateTime.now();
      }
    }

    return Ticket(
      id: safeString(ticketJson['id']),
      userId: ticketJson['userId'] is int
          ? ticketJson['userId']
          : int.tryParse(ticketJson['userId'].toString()) ?? 0,
      title: safeString(ticketJson['title']),
      status: TicketStatus.values.firstWhere(
        (e) =>
            e.toString().split('.').last ==
            safeString(ticketJson['status']).toUpperCase(),
        orElse: () => TicketStatus.OPEN,
      ),
      createdAt: safeParseDate(ticketJson['createdAt']),
      updatedAt: safeParseDate(ticketJson['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
