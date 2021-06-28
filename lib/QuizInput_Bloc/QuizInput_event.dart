import 'package:quizzr/Models/QuizController.dart';

class QuizInputEvent
{
  QuizInputEvent();
}

class LoadFormEvent extends QuizInputEvent{
  int numberOfQuestions;
  String title;
  LoadFormEvent(this.numberOfQuestions,this.title):super();
}

class SubmitQuizEvent extends QuizInputEvent{
  List<QuizController> controllers;
  String title;

  SubmitQuizEvent(this.controllers,this.title):super();
}

