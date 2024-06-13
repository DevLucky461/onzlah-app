import 'answer.dart';

class CurrentQuestion {
  int id;
  String question_type;
  String question;
  String question_image;
  int event_id;
  String fired;
  List<Answer> answer;

  CurrentQuestion({
    this.id,
    this.question_type,
    this.question,
    this.question_image,
    this.event_id,
    this.fired,
    this.answer,
  });

  factory CurrentQuestion.fromJson(Map<String, dynamic> json) {
    return CurrentQuestion(
      id: json['id'],
      question_type: json['question_type'],
      question: json['question'],
      question_image: json['question_image'],
      event_id: json['event_id'],
      fired: json['fired'],
      answer: Answer.getList(json),
    );
  }
}
