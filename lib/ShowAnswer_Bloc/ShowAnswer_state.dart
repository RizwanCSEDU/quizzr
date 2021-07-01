import 'package:quizzr/Models/Quiz.dart';

class ShowAnswerState{
  ShowAnswerState();
}

class LoadedAnswerState extends ShowAnswerState{
  Quiz quiz;
  LoadedAnswerState(this.quiz):super();
}

class LoadingState extends ShowAnswerState{
  LoadingState():super();
}

class NonExistentQuizState extends ShowAnswerState{
  NonExistentQuizState():super();
}

class ErrorState extends ShowAnswerState{
  ErrorState():super();
}