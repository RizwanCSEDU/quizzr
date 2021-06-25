import 'package:quizzr/Models/QuizController.dart';

class QuizInputEvent
{
  QuizInputEvent();
}

class LoadFormEvent extends QuizInputEvent{
  late int numberOfQuestions;
  late String title;
  LoadFormEvent(this.numberOfQuestions,this.title):super();
}

class SubmitQuizEvent extends QuizInputEvent{
  late List<QuizController> controllers;
  late String title;

  SubmitQuizEvent(this.controllers,this.title):super();
}

