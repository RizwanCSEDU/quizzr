import 'package:quizzr/Models/CustomQuizDetails.dart';

class CreatedQuizEvent {
  CreatedQuizEvent();
}

class LoadCreatedQuizEvent extends CreatedQuizEvent {
  LoadCreatedQuizEvent() : super();
}

class DeleteQuiz extends CreatedQuizEvent{
  CustomQuizDetails details;
  DeleteQuiz(this.details):super();
}
