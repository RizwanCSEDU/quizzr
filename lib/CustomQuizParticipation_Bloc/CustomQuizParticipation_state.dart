import 'package:quizzr/Models/Participation.dart';

class CustomQuizParticipationState
{
  CustomQuizParticipationState();
}

class LoadedParticipationState extends CustomQuizParticipationState
{
  List<Participation> participationDetails;
  LoadedParticipationState(this.participationDetails):super();
}

class ErrorState extends CustomQuizParticipationState
{
  ErrorState():super();
}

class NoParticipationState extends CustomQuizParticipationState
{
  NoParticipationState():super();
}

class LoadingState extends CustomQuizParticipationState{
  LoadingState():super();
}