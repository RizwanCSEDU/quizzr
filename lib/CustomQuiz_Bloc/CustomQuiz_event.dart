import 'package:quizzr/Models/CustomQuizDetails.dart';

class CustomQuizEvent {
  CustomQuizEvent();
}

class LoadQuizEvent extends CustomQuizEvent {
  String id;

  LoadQuizEvent(this.id) : super();
}

class NextQuestionEvent extends CustomQuizEvent {
  NextQuestionEvent() : super();
}

class ShowAnswerEvent extends CustomQuizEvent {
  String chosenAnswer;

  ShowAnswerEvent(this.chosenAnswer) : super();
}

class UploadScoreEvent extends CustomQuizEvent{
  CustomQuizDetails details;
  int score;
  int total;

  UploadScoreEvent(this.details,this.score,this.total):super();
}

class ShowScoreEvent extends CustomQuizEvent{
  int score;
  int total;

  ShowScoreEvent(this.score,this.total):super();
}