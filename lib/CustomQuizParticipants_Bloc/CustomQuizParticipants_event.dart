import 'package:quizzr/Models/CustomQuizDetails.dart';

class CustomQuizParticipantsEvent
{
  CustomQuizParticipantsEvent();
}

class LoadParticipantsEvent extends CustomQuizParticipantsEvent
{
  CustomQuizDetails details;
  LoadParticipantsEvent(this.details):super();
}
