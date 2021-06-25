import 'package:quizzr/Models/CustomUser.dart';

class AuthenticationState {
  final CustomUser? user;

  const AuthenticationState(this.user);
}

class Authenticated extends AuthenticationState {
  const Authenticated(CustomUser? user) : super(user);
}

class NotAuthenticated extends AuthenticationState {
  const NotAuthenticated() : super(null);
}

class LoadingState extends AuthenticationState {
  const LoadingState() : super(null);
}

class ErrorState extends AuthenticationState {
  const ErrorState() : super(null);
}
