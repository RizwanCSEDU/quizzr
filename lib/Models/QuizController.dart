import 'package:flutter/cupertino.dart';

class QuizController {
  late TextEditingController questionEditingController;
  late TextEditingController correctAnswerEditingController;
  late List<TextEditingController> incorrectAnswers;

  QuizController() {
    this.questionEditingController = TextEditingController();
    this.correctAnswerEditingController = TextEditingController();
    incorrectAnswers = [];
    for (int i = 0; i < 3; i++) {
      incorrectAnswers.add(TextEditingController());
    }
  }
}
