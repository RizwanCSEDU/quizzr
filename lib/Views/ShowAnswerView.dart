import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/ShowAnswer_Bloc/ShowAnswer_event.dart';
import 'package:quizzr/ShowAnswer_Bloc/ShowAnswer_state.dart';
import 'package:quizzr/ShowAnswer_Bloc/ShowAnswer_bloc.dart';
import 'package:quizzr/Views/ShowAnswerCard.dart';

class ShowAnswerView extends StatefulWidget{
  final String quizID;
  ShowAnswerView(this.quizID);
  @override
  _ShowAnswerViewState createState()=> _ShowAnswerViewState();
}

class _ShowAnswerViewState extends State<ShowAnswerView>{
  @override
  void initState() {
    BlocProvider.of<ShowAnswerBloc>(context)
        .add(LoadAnswersEvent(widget.quizID));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Answers",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        iconTheme: new IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: BlocBuilder<ShowAnswerBloc,ShowAnswerState>(
        builder: (context,state){

            if(state is LoadingState){
              return Center(child: CircularProgressIndicator(),);
            }else if(state is LoadedAnswerState){
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:ListView.separated(
                      padding: EdgeInsets.only(top: (10/812)*MediaQuery.of(context).size.height, bottom: (30/812)*MediaQuery.of(context).size.height, left: (10/375)*MediaQuery.of(context).size.width),
                      itemCount: state.quiz.questions.length,
                      itemBuilder: (BuildContext context,int index){
                        return ShowAnswerCard(state.quiz.questions[index], index+1);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                            height: (20/812)*MediaQuery.of(context).size.height,
                          ),
                    ),
                  ),
                ],
              );
            }else if(state is NonExistentQuizState){
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
                            "Looks like this quiz was deleted...",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w300,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ));
            }else{
              return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: (10 / 375) * MediaQuery.of(context).size.width),
                    child: Column(
                      children: [
                        SizedBox(
                          height: (30 / 812) * MediaQuery.of(context).size.height,
                        ),
                        SizedBox(
                          height: (200 / 812) * MediaQuery.of(context).size.height,
                          child: new Image.asset(
                            "images/error.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: (70 / 812) * MediaQuery.of(context).size.height,
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
                          height: (50 / 812) * MediaQuery.of(context).size.height,
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
                          height: (130 / 812) * MediaQuery.of(context).size.height,
                        ),
                        TextButton(
                            onPressed: () {
                              BlocProvider.of<ShowAnswerBloc>(context)
                                  .add(LoadAnswersEvent(widget.quizID));
                            },
                            child: Text(
                              "Retry",
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            )),
                      ],
                    ),
                  ));
            }


        },
      ),
    );
  }
}