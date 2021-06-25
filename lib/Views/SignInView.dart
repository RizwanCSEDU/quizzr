import 'package:quizzr/Authentication_Bloc/Authentication_bloc.dart';
import 'package:quizzr/Authentication_Bloc/Authentication_event.dart';
import 'package:quizzr/Authentication_Bloc/Authentication_state.dart';
import 'package:quizzr/Services/Authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SignInView extends StatefulWidget {
  final Function toggleView;

  SignInView({required this.toggleView});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController emailEdit = new TextEditingController();
  TextEditingController passwordEdit = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong! Please try again.')));
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return (Center(
            child: CircularProgressIndicator(),
          ));
        } else {
          return ListView(
            padding: EdgeInsets.only(top: (250/812)*MediaQuery.of(context).size.height, left: (30/375)*MediaQuery.of(context).size.width, right: (30/375)*MediaQuery.of(context).size.width),
            children: <Widget>[
              Container(
                child: Column(children: <Widget>[
                  Center(
                    child: Text("Quizzr",
                        style: GoogleFonts.dancingScript(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                                color: Colors.blue))),
                  ),
                  SizedBox(
                    height: (20/812)*MediaQuery.of(context).size.height,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailEdit,
                          validator: (val) {
                            if (val != null) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please Enter Correct Email";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: (40.0/812)*MediaQuery.of(context).size.height,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: passwordEdit,
                          validator: (val) {
                            if (val != null) {
                              return val.length > 6
                                  ? null
                                  : "password has to have 6+ characters";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: (40.0/812)*MediaQuery.of(context).size.height,
                  ),
                  GestureDetector(
                    child: Container(
                      height: (50/812)*MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: LinearGradient(colors: [
                            const Color(0xff43CBFF),
                            const Color(0xff9708CC),
                          ])),
                      child: Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState!.validate() == true) {
                        try {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LoadEvent());
                          await RepositoryProvider.of<Authentication>(context)
                              .signInWithEmailAndPassword(
                                  emailEdit.text.toString(),
                                  passwordEdit.text.toString());
                        } catch (e) {
                          print(e);
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(ErrorEvent());
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: (10/812)*MediaQuery.of(context).size.height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Haven't registered yet?"),
                      GestureDetector(
                        child: Text(
                          "Register now.",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          widget.toggleView();
                        },
                      )
                    ],
                  ),
                ]),
              )
            ],
          );
        }
      }),
    );
  }
}
