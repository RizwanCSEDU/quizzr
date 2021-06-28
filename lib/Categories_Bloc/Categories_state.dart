import 'package:quizzr/Models/Categories.dart';

class CategoriesState {
  CategoriesState();
}

class LoadingState extends CategoriesState {
  LoadingState() : super();
}

class LoadedCategoriesState extends CategoriesState {
  Categories categories;

  LoadedCategoriesState(this.categories) : super();
}

class ErrorState extends CategoriesState {
  ErrorState() : super();
}
