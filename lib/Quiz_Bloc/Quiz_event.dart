class QuizEvent {
  QuizEvent();
}

class LoadQuizEvent extends QuizEvent {
  int id;
  LoadQuizEvent(this.id) : super();
}

class NextQuestionEvent extends QuizEvent {
  NextQuestionEvent() : super();
}

class ShowAnswerEvent extends QuizEvent {
  String chosenAnswer;

  ShowAnswerEvent(this.chosenAnswer) : super();
}
