import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CustomQuizParticipants_Bloc/CustomQuizParticipants_event.dart';
import 'package:quizzr/CustomQuizParticipants_Bloc/CustomQuizParticipants_state.dart';
import 'package:quizzr/Models/Participant.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';

class CustomQuizParticipantsBloc extends Bloc<CustomQuizParticipantsEvent,CustomQuizParticipantsState>{
  final CustomQuizHelper _helper;

  CustomQuizParticipantsBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<CustomQuizParticipantsState> mapEventToState(CustomQuizParticipantsEvent event) async* {
    if(event is LoadParticipantsEvent)
      {
        yield LoadingState();
        try{
          List<Participant> participants = await _helper.getParticipants(event.details.id);
          if(participants.isEmpty){
            yield NoParticipantsState();
          }
          else {
              yield LoadedParticipantsState(participants);
            }
        }catch(e){
          ErrorState();
        }
      }
  }
}