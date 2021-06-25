import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Services/Authentication.dart';
import 'package:quizzr/Authentication_Bloc/Authentication_state.dart';
import 'package:quizzr/Authentication_Bloc/Authentication_event.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Authentication _authentication;
  late StreamSubscription<dynamic> _userSubscription;

  AuthenticationBloc(Authentication authentication)
      : _authentication = authentication,
        super(new LoadingState()) {
    _userSubscription = _authentication.user.listen((customUser) {
      if (customUser == null) {
        print('User is null');
      } else {
        print(customUser);
        print(customUser.uid);
        print(customUser.email);
      }
      add(new AuthenticationEvent(customUser));
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is ErrorEvent) {
      print("Error State");
      yield ErrorState();
    } else if (event is LoadEvent) {
      print("Loading State");
      yield LoadingState();
    } else {
      if (event.user == null) {
        print('Not Authenticated');
        yield NotAuthenticated();
      } else {
        try {
          print('Authenticated');
          yield Authenticated(event.user);
        } catch (e) {
          yield NotAuthenticated();
        }
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
