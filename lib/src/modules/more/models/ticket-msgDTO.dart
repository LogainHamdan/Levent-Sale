class TicketMessageDTO {
  final String title;
  final String message;

  TicketMessageDTO({
    required this.title,
    required this.message,
  });
  factory TicketMessageDTO.fromJson(Map<String, dynamic> json) {
    return TicketMessageDTO(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
    };
  }
}
