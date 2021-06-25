class Question {

  late String question;
  late String correctAnswer;
  late List<String> incorrectAnswers;
  late List<String> options;

  Question({required this.question,required this.correctAnswer,required this.incorrectAnswers,required this.options});

  Question.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
    options = json['incorrect_answers'].cast<String>();
    options.add(correctAnswer);
    options.shuffle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }

}
