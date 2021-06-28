import 'package:quizzr/Models/Quiz.dart';

class QuizState {

  QuizState();
}

class LoadingState extends QuizState {
  LoadingState() : super();
}

class ErrorState extends QuizState {
  ErrorState() : super();
}

class ShowQuestionState extends QuizState {

   int score;
   int index;
   Quiz quiz;

  ShowQuestionState(this.score, this.index, this.quiz) : super();
}

class ShowAnswerState extends QuizState {

   int score;
   int index;
   String chosenAnswer;
   Quiz quiz;

  ShowAnswerState(this.score, this.index, this.chosenAnswer, this.quiz)
      : super();
}
