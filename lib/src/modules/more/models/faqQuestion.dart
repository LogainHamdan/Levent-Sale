class FAQuestion {
  final String? id;
  final String? question;

  FAQuestion({
    this.id,
    this.question,
  });

  factory FAQuestion.fromJson(Map<String, dynamic> json) {
    return FAQuestion(
      id: json['id'] as String,
      question: json['question'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
    };
  }

  @override
  String toString() => 'FAQ(id: $id, question: $question)';
}
