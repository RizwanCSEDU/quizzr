import 'package:quizzr/Views/SignInView.dart';
import 'package:quizzr/Views/SignUpView.dart';
import 'package:flutter/material.dart';

class AuthenticateView extends StatefulWidget {
  @override
  _AuthenticateViewState createState() => _AuthenticateViewState();
}

class _AuthenticateViewState extends State<AuthenticateView> {
  bool isSignInView = true;

  void toggleView() {
    isSignInView = !isSignInView;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isSignInView == true) {
      print('sign in');
      return SignInView(
        toggleView: toggleView,
      );
    } else {
      print('sign up');
      return SignUpView(
        toggleView: toggleView,
      );
    }
  }
}
