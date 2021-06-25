import 'package:quizzr/Models/Quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_event.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_state.dart';
import 'package:quizzr/Services/API.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final API _api;

  QuizBloc(API api)
      : _api = api,
        super(LoadingState());

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is LoadQuizEvent) {
      if (state is! LoadingState) {
        yield LoadingState();
      }
      try {
        Quiz quiz = await _api.fetchQuiz(event.id);
        yield ShowQuestionState(0, 0, quiz);
      } catch (e) {
        yield ErrorState();
      }
    } else if (event is NextQuestionEvent && state is ShowAnswerState) {
      ShowAnswerState curState = state as ShowAnswerState;
      yield ShowQuestionState(
          curState.score, curState.index + 1, curState.quiz);
    } else if (event is ShowAnswerEvent && state is ShowQuestionState) {
      ShowQuestionState curState = state as ShowQuestionState;

      if (event.chosenAnswer ==
          curState.quiz.questions[curState.index].correctAnswer) {
        yield ShowAnswerState(curState.score + 1, curState.index,
            event.chosenAnswer, curState.quiz);
      } else {
        yield ShowAnswerState(
            curState.score, curState.index, event.chosenAnswer, curState.quiz);
      }
    }
  }
}
