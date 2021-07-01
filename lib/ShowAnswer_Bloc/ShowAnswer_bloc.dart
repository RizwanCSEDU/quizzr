import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Exceptions/NonExistentQuiz.dart';
import 'package:quizzr/Models/Quiz.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';
import 'package:quizzr/ShowAnswer_Bloc/ShowAnswer_state.dart';
import 'package:quizzr/ShowAnswer_Bloc/ShowAnswer_event.dart';

class ShowAnswerBloc extends Bloc<ShowAnswerEvent,ShowAnswerState>{
  final CustomQuizHelper _helper;

  ShowAnswerBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<ShowAnswerState> mapEventToState(ShowAnswerEvent event)async* {
    if(event is LoadAnswersEvent){
      yield LoadingState();
      try{
        Quiz quiz = await _helper.getQuiz(event.quizID);
        yield LoadedAnswerState(quiz);
      }on NonExistentQuiz catch(exception){
        print(exception);
        yield NonExistentQuizState();
      }catch(exception){
        print(exception);
        yield ErrorState();
      }
    }

  }




}