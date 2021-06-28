import 'package:quizzr/Models/CustomUser.dart';

class AuthenticationEvent {
   CustomUser? user;

   AuthenticationEvent(this.user);
}

class ErrorEvent extends AuthenticationEvent {
   ErrorEvent() : super(null);
}

class LoadEvent extends AuthenticationEvent {
   LoadEvent() : super(null);
}
