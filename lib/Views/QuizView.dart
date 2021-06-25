import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Models/TriviaCategory.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_bloc.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_event.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_state.dart';
import 'package:quizzr/Views/OptionCard.dart';
import 'package:quizzr/Views/QuestionCard.dart';
import 'package:quizzr/Views/ScoreView.dart';

class QuizView extends StatefulWidget {
  final TriviaCategory category;
  QuizView(this.category);
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {

  @override
  void initState() {
    BlocProvider.of<QuizBloc>(context)
        .add(LoadQuizEvent(widget.category.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.category.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
            iconTheme: new IconThemeData(color: Colors.black),
            brightness: Brightness.light,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                child: Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.close),),
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
          body: BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
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
                      itemCount: state.quiz.questions[state.index].options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new OptionCard(
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
                      itemCount: state.quiz.questions[state.index].options.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new OptionCard(
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
                          BlocProvider.of<QuizBloc>(context)
                              .add(NextQuestionEvent());
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScoreView(
                                      state.score, state.quiz.questions.length)));
                        }
                      },
                    ),
                  ),
                ],
              );
            } else if(state is ErrorState){
              return Center(
                child: Column(
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<QuizBloc>(context)
                              .add(LoadQuizEvent(widget.category.id));
                        },
                        icon: Icon(Icons.error_rounded)),
                    Text("Something went wrong! Press the button to try again")
                  ],
                ),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
        onWillPop:  () async => false,
    );
  }
}
