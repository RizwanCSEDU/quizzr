import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CustomQuizParticipation_Bloc/CustomQuizParticipation_bloc.dart';
import 'package:quizzr/CustomQuizParticipation_Bloc/CustomQuizParticipation_event.dart';
import 'package:quizzr/CustomQuizParticipation_Bloc/CustomQuizParticipation_state.dart';
import 'package:quizzr/Views/CustomQuizParticipationCard.dart';

class CustomQuizParticipationView extends StatefulWidget {
  @override
  _CustomQuizParticipationViewState createState() =>
      _CustomQuizParticipationViewState();
}

class _CustomQuizParticipationViewState
    extends State<CustomQuizParticipationView> {
  @override
  void initState(){
    BlocProvider.of<CustomQuizParticipationBloc>(context).add(LoadParticipationEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Participation",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        iconTheme: new IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: BlocBuilder<CustomQuizParticipationBloc,
          CustomQuizParticipationState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedParticipationState) {
            return new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                      child: new ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: (5/375)*MediaQuery.of(context).size.width,vertical:(5/812)*MediaQuery.of(context).size.height),
                    itemCount: state.participationDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new CustomQuizParticipationCard(
                          state.participationDetails[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: (20/812)*MediaQuery.of(context).size.height,
                    ),
                  )),
                ]);
          } else if (state is NoParticipationState) {
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
                      "Looks like you haven't participated in a quiz yet",
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
          } else {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (10/812)*MediaQuery.of(context).size.height),
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
                    height: (100/812)*MediaQuery.of(context).size.height,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Oooops!",
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
                      "Looks like something went wrong.",
                      style: TextStyle(
                          color: Colors.red,
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
        },
      ),
    );
  }
}
