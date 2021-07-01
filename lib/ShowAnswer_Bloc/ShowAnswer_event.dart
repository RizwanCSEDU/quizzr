class ShowAnswerEvent{
  ShowAnswerEvent();
}

class LoadAnswersEvent extends ShowAnswerEvent{
  String quizID;
  LoadAnswersEvent(this.quizID):super();
}