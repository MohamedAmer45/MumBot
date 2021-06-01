class Answer {
  int id;
  final String body;
  final String date;
  final int questionId;
  final String specialistId;

  Answer({this.id, this.body, this.date, this.questionId, this.specialistId});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      body: json['answer_body'],
      date: json['answer_date'],
      questionId: json['answer_question_id'],
      specialistId: json['answer_specialist_id'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'answer_body': body,
        'answer_date': date,
        'answer_question_id': questionId,
        'answer_specialist_id': specialistId,
      };
}
