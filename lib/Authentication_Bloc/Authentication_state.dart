import 'package:quizzr/Models/CustomUser.dart';

class AuthenticationState {
  CustomUser? user;

  AuthenticationState(this.user);
}

class Authenticated extends AuthenticationState {
   Authenticated(CustomUser? user) : super(user);
}

class NotAuthenticated extends AuthenticationState {
   NotAuthenticated() : super(null);
}

class LoadingState extends AuthenticationState {
   LoadingState() : super(null);
}

class ErrorState extends AuthenticationState {
   ErrorState() : super(null);
}
