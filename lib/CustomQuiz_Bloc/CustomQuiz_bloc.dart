import 'package:quizzr/Exceptions/NonExistentQuiz.dart';
import 'package:quizzr/Models/CustomQuizDetails.dart';
import 'package:quizzr/Models/Participant.dart';
import 'package:quizzr/Models/Participation.dart';
import 'package:quizzr/Models/Quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_event.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_state.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';

class CustomQuizBloc extends Bloc<CustomQuizEvent, CustomQuizState> {
  final CustomQuizHelper _helper;

  CustomQuizBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<CustomQuizState> mapEventToState(CustomQuizEvent event) async* {
    if (event is LoadQuizEvent) {

      if (state is! LoadingState) {
        yield LoadingState();
      }

      try {
        var result = await _helper.checkParticipation(event.id);
        if(result == false){
          try{
            CustomQuizDetails details = await _helper.getQuizDetails(event.id);
            Quiz quiz = await _helper.getQuiz(event.id);
            yield ShowQuestionState(details, 0, 0, quiz);
          }on NonExistentQuiz catch(exception){
            print(exception);
            yield NonExistentQuizState();
          }catch(exception){
            print(exception);
            yield ErrorState();
          }
        }
        else{
          Participant record = result as Participant;
          yield ShowScoreState(record.score, record.total);
        }

      } on NonExistentQuiz catch(exception){
        print(exception);
        yield NonExistentQuizState();
      }catch(exception){
        print(exception);
        yield ErrorState();
      }
    } else if (event is NextQuestionEvent && state is ShowAnswerState) {
      ShowAnswerState curState = state as ShowAnswerState;
      yield ShowQuestionState(
          curState.details, curState.score, curState.index + 1, curState.quiz);
    } else if (event is ShowAnswerEvent && state is ShowQuestionState) {
      ShowQuestionState curState = state as ShowQuestionState;

      if (event.chosenAnswer ==
          curState.quiz.questions[curState.index].correctAnswer) {
        yield ShowAnswerState(curState.details, curState.score + 1,
            curState.index, event.chosenAnswer, curState.quiz);
      } else {
        yield ShowAnswerState(curState.details, curState.score, curState.index,
            event.chosenAnswer, curState.quiz);
      }
    }
    else if(event is UploadScoreEvent){

      yield LoadingState();

      try{
        await _helper.updateParticipation(event.details, event.score, event.total);
        yield ShowScoreState(event.score, event.total);
      }catch(e){
        yield ErrorUploadingScoreState(event.details,event.score, event.total);
      }


    }
    else if(event is ShowScoreEvent && state is ErrorUploadingScoreState){
      ErrorUploadingScoreState curState = state as ErrorUploadingScoreState;
      yield ShowScoreState(curState.score,curState.total);
    }
  }
}
