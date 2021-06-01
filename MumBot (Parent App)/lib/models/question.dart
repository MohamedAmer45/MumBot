class Question {
  int id;
  final String body;
  final String date;
  final int adminId;
  final String tags;

  Question({
    this.id,
    this.body,
    this.date,
    this.adminId,
    this.tags,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      body: json['question_body'],
      date: json['question_date'],
      adminId: json['question_admin_id'],
      tags: json['question_tags'],
    );
  }
  dynamic toJson() => {
        'id': id,
        'question_body': body,
        'question_date': date,
        'question_admin_id': adminId,
        'question_tags': tags,
      };
}
