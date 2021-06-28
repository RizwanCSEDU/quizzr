import 'package:quizzr/Models/CustomQuizDetails.dart';

class CreatedQuizState {
  CreatedQuizState();
}

class LoadingState extends CreatedQuizState {
  LoadingState() : super();
}

class LoadedCreatedQuizState extends CreatedQuizState {
  List<CustomQuizDetails> details;

  LoadedCreatedQuizState(this.details) : super();
}

class ErrorState extends CreatedQuizState {
  ErrorState() : super();
}

class NoQuizCreatedState extends CreatedQuizState{
  NoQuizCreatedState():super();
}
