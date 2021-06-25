import 'package:quizzr/Models/Categories.dart';
import 'package:quizzr/Categories_Bloc/Categories_event.dart';
import 'package:quizzr/Categories_Bloc/Categories_state.dart';
import 'package:quizzr/Services/API.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final API _api;

  CategoriesBloc(API api)
      : _api = api,
        super(LoadingState());

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is LoadCategoriesEvent && state is! LoadedCategoriesState) {
      if (state is! LoadingState) {
        yield LoadingState();
      }
      try {
        Categories categories = await _api.fetchCategories();
        yield LoadedCategoriesState(categories: categories);
      } catch (e) {
        yield ErrorState();
      }
    }
  }
}
