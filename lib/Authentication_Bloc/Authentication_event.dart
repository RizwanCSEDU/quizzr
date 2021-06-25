import 'package:quizzr/Models/CustomUser.dart';

class AuthenticationEvent {
  final CustomUser? user;

  const AuthenticationEvent(this.user);
}

class ErrorEvent extends AuthenticationEvent {
  const ErrorEvent() : super(null);
}

class LoadEvent extends AuthenticationEvent {
  const LoadEvent() : super(null);
}
