import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_event.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_state.dart';
import 'package:quizzr/Models/CustomQuizDetails.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';

class CreatedQuizBloc extends Bloc<CreatedQuizEvent, CreatedQuizState> {
  final CustomQuizHelper _helper;

  CreatedQuizBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<CreatedQuizState> mapEventToState(CreatedQuizEvent event) async* {
    if (event is LoadCreatedQuizEvent && state is! LoadedCreatedQuizState) {
      if (state is! LoadingState) {
        yield LoadingState();
      }
      try {
        List<CustomQuizDetails> details = await _helper.getListOfCreatedQuiz();
        if(details.isEmpty){
          yield NoQuizCreatedState();
        }
        else{
          yield LoadedCreatedQuizState(details: details);
        }
      } catch (e) {
        yield ErrorState();
      }
    }else if(event is DeleteQuiz){
      yield LoadingState();
      try{
        await _helper.deleteQuiz(event.details);
        List<CustomQuizDetails> details = await _helper.getListOfCreatedQuiz();
        if(details.isEmpty){
          yield NoQuizCreatedState();
        }
        else{
          yield LoadedCreatedQuizState(details: details);
        }
      }catch(e){
        yield ErrorState();
      }
    }
  }
}
