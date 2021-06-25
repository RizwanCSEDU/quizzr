
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_bloc.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_event.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_state.dart';
import 'package:quizzr/Views/CreatedQuizCard.dart';

class CreatedQuizView extends StatefulWidget{
  @override
  _CreatedQuizViewState createState()=> _CreatedQuizViewState();
}

class _CreatedQuizViewState extends State<CreatedQuizView>
{
  @override
  void initState(){
    BlocProvider.of<CreatedQuizBloc>(context).add(LoadCreatedQuizEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Quizzes",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        iconTheme: new IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: BlocBuilder<CreatedQuizBloc,CreatedQuizState>(
        builder: (context,state){
          if(state is LoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is LoadedCreatedQuizState){
            return new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                      child: new ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: (5/375)*MediaQuery.of(context).size.width,vertical: (5/812)*MediaQuery.of(context).size.height),
                        itemCount: state.details.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new CreatedQuizCard(details: state.details[index],);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: (20/812)*MediaQuery.of(context).size.height,
                            ),
                      )),
                ]);
          }
          else if(state is NoQuizCreatedState){
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
                          "images/sad.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: (100/812)*MediaQuery.of(context).size.height,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Hmmm...",
                          style: TextStyle(
                              color: Colors.blueGrey,
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
                          "Looks like you haven't created a quiz yet",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: (100/812)*MediaQuery.of(context).size.height,
                      ),

                    ],
                  ),
                ));
          }
          else{
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
                            BlocProvider.of<CreatedQuizBloc>(context)
                                .add(LoadCreatedQuizEvent());
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