import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_bloc.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_event.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Views/SubmittedSuccessfullyView.dart';

class QuizInputView extends StatefulWidget {
  final int numberOfQuestions;

  final String title;

  QuizInputView(this.numberOfQuestions, this.title);

  @override
  _QuizInputViewState createState() => _QuizInputViewState();
}

class _QuizInputViewState extends State<QuizInputView> {
  @override
  void initState() {
    BlocProvider.of<QuizInputBloc>(context)
        .add(LoadFormEvent(widget.numberOfQuestions, widget.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: new IconThemeData(color: Colors.black),
          brightness: Brightness.light,
        ),
        body: BlocConsumer<QuizInputBloc, QuizInputState>(
          listener: (context,state){
            if(state is ErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Something went wrong! Please try again.')));
            }
            else if(state is SubmittedSuccessfullyState){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>SubmittedSuccessfullyView(state.id) ));
            }
          },
          builder: (context, state) {
            if (state is LoadFormState) {
              final _formKey = GlobalKey<FormState>();
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: (15/375)*MediaQuery.of(context).size.width,/*vertical: (15/812)*MediaQuery.of(context).size.height*/),
                children: [
                  SizedBox(
                    height: (20/812)*MediaQuery.of(context).size.height,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: List.generate(state.controllers.length, (index) {
                        return Column(
                          children: [
                            Text(
                              "Question" + (index + 1).toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 6,
                              maxLines: 6,
                              keyboardType: TextInputType.multiline,
                              controller: state
                                  .controllers[index].questionEditingController,
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Question",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller: state.controllers[index]
                                  .correctAnswerEditingController,
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Correct Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[0],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[1],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[2],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: (50/812)*MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        //color: Colors.blue,
                        gradient: LinearGradient(
                          //center: Alignment(0.0, 0.0),
                          //radius: 0.5,
                          begin: Alignment(1.13, 0.26),
                          end: Alignment(-0.69, -1.36),
                          colors: [const Color(0xff0085db), const Color(0xff350857)],
                          stops: [0.0, 1.0],
                          //transform: GradientXDTransform(
                          //1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState!.validate() == true) {
                        BlocProvider.of<QuizInputBloc>(context)
                            .add(SubmitQuizEvent(state.controllers,state.title));
                      } else {
                        print("not ok");
                      }
                    },
                  ),
                  SizedBox(
                    height: (20/812)*MediaQuery.of(context).size.height,
                  ),
                ],
              );
            }
            else if (state is ErrorState) {
              final _formKey = GlobalKey<FormState>();
              return ListView(
                padding: EdgeInsets.all(15),
                children: [
                  SizedBox(
                    height: (20/812)*MediaQuery.of(context).size.height,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: List.generate(state.controllers.length, (index) {
                        return Column(
                          children: [
                            index == 0
                                ? Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                SizedBox(
                                  width: (60/375)*MediaQuery.of(context).size.width,
                                ),
                                Text(
                                  "Question" + (index + 1).toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ],
                            )
                                : Text(
                              "Question" + (index + 1).toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 6,
                              maxLines: 6,
                              keyboardType: TextInputType.multiline,
                              controller: state
                                  .controllers[index].questionEditingController,
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Question",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller: state.controllers[index]
                                  .correctAnswerEditingController,
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Correct Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[0],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[1],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                            TextFormField(
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.multiline,
                              controller:
                              state.controllers[index].incorrectAnswers[2],
                              validator: (val) {
                                if (val != null) {
                                  return val.length > 0
                                      ? null
                                      : "This field can't be empty";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Incorrect Answer",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: (30/812)*MediaQuery.of(context).size.height,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: (50/812)*MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        //color: Colors.blue,
                        gradient: LinearGradient(
                          //center: Alignment(0.0, 0.0),
                          //radius: 0.5,
                          begin: Alignment(1.13, 0.26),
                          end: Alignment(-0.69, -1.36),
                          colors: [const Color(0xff0085db), const Color(0xff350857)],
                          stops: [0.0, 1.0],
                          //transform: GradientXDTransform(
                          //1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState!.validate() == true) {
                        BlocProvider.of<QuizInputBloc>(context)
                            .add(SubmitQuizEvent(state.controllers,state.title));
                      } else {
                        print("not ok");
                      }
                    },
                  ),
                  SizedBox(
                    height: (20/812)*MediaQuery.of(context).size.height,
                  ),
                ],
              );
            }
            else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
