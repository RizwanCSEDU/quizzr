import 'package:quizzr/Models/QuizController.dart';

class QuizInputState
{
  QuizInputState();
}

class ErrorState extends QuizInputState
{
  late List<QuizController> controllers;
  late String title;

  ErrorState(this.controllers,this.title):super();
}

class LoadFormState extends QuizInputState
{

  late String title;
  late List<QuizController> controllers;
  LoadFormState(this.controllers,this.title):super();
}

class LoadingState extends QuizInputState
{
  LoadingState():super();
}

class SubmittedSuccessfullyState extends QuizInputState
{
  late String id;
  SubmittedSuccessfullyState(this.id):super();
}