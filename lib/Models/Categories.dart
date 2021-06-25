import 'TriviaCategory.dart';

class Categories {
  late List<TriviaCategory> triviaCategories;

  Categories({required this.triviaCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['trivia_categories'] != null) {
      triviaCategories = <TriviaCategory>[];
      json['trivia_categories'].forEach((v) {
        triviaCategories.add(new TriviaCategory.fromJson(v));
      });
    }
  }


}
