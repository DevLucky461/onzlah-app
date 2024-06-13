class Answer {
  int id;
  String answer;
  int question_id;
  String status;
  String percent;

  Answer({
    this.id,
    this.answer,
    this.question_id,
    this.status,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      answer: json['answer'],
      question_id: json['question_id'],
      status: json['status'],
    );
  }

  static getList(json) {
    var tagObjJson = json['answer'] as List;
    List<Answer> _tags = tagObjJson.map((tagJson) => Answer.fromJson(tagJson)).toList();
    return _tags;
  }
}
