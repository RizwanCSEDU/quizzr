import 'package:quizzr/Models/CustomQuizDetails.dart';
import 'package:quizzr/Models/Participant.dart';
import 'package:quizzr/Models/Question.dart';
import 'package:quizzr/Models/Quiz.dart';
import 'package:quizzr/Models/QuizController.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_event.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_state.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizInputBloc extends Bloc<QuizInputEvent, QuizInputState> {
  final CustomQuizHelper _helper;

  QuizInputBloc(CustomQuizHelper helper)
      : _helper = helper,
        super(LoadingState());

  @override
  Stream<QuizInputState> mapEventToState(QuizInputEvent event) async* {
    if (event is LoadFormEvent) {
      List<QuizController> controllers = [];

      for (int i = 0; i < event.numberOfQuestions; i++) {
        controllers.add(QuizController());
      }

      yield LoadFormState(controllers,event.title);
    } else if (event is SubmitQuizEvent) {

      if(state is! LoadingState){
        yield LoadingState();
      }

      List<Question> questions = [];

      for (int i = 0; i < event.controllers.length; i++) {
        List<String> options = [];

        List<String> incorrectAnswers = [];

        for (int j = 0; j < 3; j++) {
          options.add(event.controllers[i].incorrectAnswers[j].text.toString());

          incorrectAnswers
              .add(event.controllers[i].incorrectAnswers[j].text.toString());
        }
        options.add(event.controllers[i].correctAnswerEditingController.text
            .toString());
        questions.add(Question(
            question:
                event.controllers[i].questionEditingController.text.toString(),
            correctAnswer: options[3],
            options: options,
            incorrectAnswers: incorrectAnswers));
      }
      Quiz quiz = new Quiz(questions:questions);
      CustomQuizDetails details= new CustomQuizDetails(title: event.title);
      try {
        await _helper.createQuiz(details,quiz);
        yield SubmittedSuccessfullyState(details.id);
      } catch (e) {
        yield ErrorState(event.controllers, event.title);
      }
    }
  }
}
