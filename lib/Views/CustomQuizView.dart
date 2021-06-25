import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_bloc.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_event.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_state.dart';
import 'package:quizzr/Views/QuestionCard.dart';
import 'package:quizzr/Views/ScoreView.dart';

import 'CustomQuizOptionCard.dart';

class CustomQuizView extends StatefulWidget {
  final String id;

  CustomQuizView(this.id);

  @override
  _CustomQuizViewState createState() => _CustomQuizViewState();
}

class _CustomQuizViewState extends State<CustomQuizView> {
  @override
  void initState() {
    BlocProvider.of<CustomQuizBloc>(context).add(LoadQuizEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<CustomQuizBloc, CustomQuizState>(
            builder: (context, state) {
              if (state is ShowQuestionState) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(state.details.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                );
              } else if (state is ShowAnswerState) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(state.details.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                );
              } else {
                return Container();
              }
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: new IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: (20/375)*MediaQuery.of(context).size.width),
                child: Icon(Icons.close),
              ),
              onTap: () async {
                bool result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Are you sure you want to quit?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(false);
                            },
                            child: Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(true);
                            },
                            child: Text("Yes"),
                          ),
                        ],
                      );
                    });

                if (result == true) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
        body: BlocConsumer<CustomQuizBloc, CustomQuizState>(
          listener: (context, state) {
            if (state is ShowScoreState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ScoreView(state.score, state.total)));
            }
          },
          builder: (context, state) {
            if (state is ShowQuestionState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  QuestionCard(state.quiz.questions[state.index].question,
                      state.index, state.quiz.questions.length),
                  new Expanded(
                    child: new ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: (5/375)*MediaQuery.of(context).size.width,vertical: (5/812)*MediaQuery.of(context).size.height),
                      itemCount:
                          state.quiz.questions[state.index].options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new CustomQuizOptionCard(
                            state.quiz.questions[state.index].options[index],
                            state.quiz.questions[state.index].correctAnswer);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: (10/812)*MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is ShowAnswerState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  QuestionCard(state.quiz.questions[state.index].question,
                      state.index, state.quiz.questions.length),
                  new Expanded(
                    child: new ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: (5/375)*MediaQuery.of(context).size.width,vertical: (5/812)*MediaQuery.of(context).size.height),
                      itemCount:
                          state.quiz.questions[state.index].options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new CustomQuizOptionCard(
                            state.quiz.questions[state.index].options[index],
                            state.quiz.questions[state.index].correctAnswer);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: (10/812)*MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (90/375)*MediaQuery.of(context).size.width,vertical: (25/812)*MediaQuery.of(context).size.height),
                    child: GestureDetector(
                      child: Container(
                        height: (50/812)*MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Color(0xf2402a5d),
                          border: Border.all(width: 3.0, color: Colors.black12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x27000000),
                              offset: Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (state.index < state.quiz.questions.length - 1) {
                          BlocProvider.of<CustomQuizBloc>(context)
                              .add(NextQuestionEvent());
                        } else {
                          BlocProvider.of<CustomQuizBloc>(context).add(
                              UploadScoreEvent(state.details, state.score,
                                  state.quiz.questions.length));
                        }
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ErrorState) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (10/375)*MediaQuery.of(context).size.width),
                child: Column(
                  children: [
                    SizedBox(
                      height: (30/812)*MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      height: (200/812)*MediaQuery.of(context).size.height,
                      child: new Image.asset(
                        "images/error.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: (70/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Ooops!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 38),
                      ),
                    ),
                    SizedBox(
                      height: (50/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "There was an error!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Make sure you're connected to the internet",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: (130/812)*MediaQuery.of(context).size.height,
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CustomQuizBloc>(context)
                              .add(LoadQuizEvent(widget.id));
                        },
                        child: Text(
                          "Retry",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )),
                  ],
                ),
              ));
            } else if (state is NonExistentQuizState) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (10/375)*MediaQuery.of(context).size.width),
                child: Column(
                  children: [
                    SizedBox(
                      height: (30/812)*MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      height: (200/812)*MediaQuery.of(context).size.height,
                      child: new Image.asset(
                        "images/error.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: (70/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Ooops!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 38),
                      ),
                    ),
                    SizedBox(
                      height: (50/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "There was an error!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Check if you entered a valid quiz code...",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: (130/812)*MediaQuery.of(context).size.height,
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CustomQuizBloc>(context)
                              .add(LoadQuizEvent(widget.id));
                        },
                        child: Text(
                          "Retry",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )),
                  ],
                ),
              ));
            } else if (state is ErrorUploadingScoreState) {
              return Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: (10/375)*MediaQuery.of(context).size.width),
                child: Column(
                  children: [
                    SizedBox(
                      height: (30/812)*MediaQuery.of(context).size.height,
                    ),
                    SizedBox(
                      height: (200/812)*MediaQuery.of(context).size.height,
                      child: new Image.asset(
                        "images/error.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: (70/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Ooops!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 38),
                      ),
                    ),
                    SizedBox(
                      height: (50/812)*MediaQuery.of(context).size.height,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "There was an error uploading the score!",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: (100/812)*MediaQuery.of(context).size.height,
                    ),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CustomQuizBloc>(context).add(
                              UploadScoreEvent(
                                  state.quizDetails, state.score, state.total));
                        },
                        child: Text(
                          "Retry",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScoreView(state.score, state.total)));
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        )),
                  ],
                ),
              ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
