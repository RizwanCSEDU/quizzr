import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CustomQuizParticipation_Bloc/CustomQuizParticipation_event.dart';
import 'package:quizzr/CustomQuizParticipation_Bloc/CustomQuizParticipation_state.dart';
import 'package:quizzr/Models/Participation.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';

class CustomQuizParticipationBloc extends Bloc<CustomQuizParticipationEvent,CustomQuizParticipationState>{
  final CustomQuizHelper _helper;

  CustomQuizParticipationBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<CustomQuizParticipationState> mapEventToState(CustomQuizParticipationEvent event) async* {
    if(event is LoadParticipationEvent)
    {
      yield LoadingState();
      try{
        List<Participation> participation = await _helper.getParticipation();
        if(participation.isEmpty){
          yield NoParticipationState();
        }
        else {
          yield LoadedParticipationState(participation);
        }
      }catch(e){
        ErrorState();
      }
    }
  }
}