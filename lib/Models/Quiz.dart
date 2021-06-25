import 'Question.dart';

class Quiz {
  late List<Question> questions;

  Quiz({required this.questions});

  Quiz.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      questions = <Question>[];
      json['results'].forEach((v) {
        questions.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.questions.map((v) => v.toJson()).toList();
    return data;
  }

}
