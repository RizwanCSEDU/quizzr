import 'package:quizzr/Models/QuizController.dart';

class QuizInputState
{
  QuizInputState();
}

class ErrorState extends QuizInputState
{
  List<QuizController> controllers;
  String title;

  ErrorState(this.controllers,this.title):super();
}

class LoadFormState extends QuizInputState
{

  String title;
  List<QuizController> controllers;
  LoadFormState(this.controllers,this.title):super();
}

class LoadingState extends QuizInputState
{
  LoadingState():super();
}

class SubmittedSuccessfullyState extends QuizInputState
{
  String id;
  SubmittedSuccessfullyState(this.id):super();
}