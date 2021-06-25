import 'package:quizzr/Models/Participant.dart';

class CustomQuizParticipantsState
{
  CustomQuizParticipantsState();
}

class LoadedParticipantsState extends CustomQuizParticipantsState
{
  List<Participant> participants;
  LoadedParticipantsState(this.participants):super();
}

class ErrorState extends CustomQuizParticipantsState
{
  ErrorState():super();
}

class NoParticipantsState extends CustomQuizParticipantsState
{
  NoParticipantsState():super();
}

class LoadingState extends CustomQuizParticipantsState{
  LoadingState():super();
}