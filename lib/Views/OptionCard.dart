import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_bloc.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_event.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_state.dart';

class OptionCard extends StatefulWidget {
  final String option;
  final String correctAnswer;

  OptionCard(this.option, this.correctAnswer);

  _OptionCardState createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool showAnswer = false;
  //Color color = Colors.blue;
  List<Color> colors = [const Color(0xf24d88d6), const Color(0xf22b5088)];

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
      listener: (context, state) {
        if (state is ShowAnswerState) {
          showAnswer = true;
          if (widget.option == widget.correctAnswer) {
            colors = [Colors.green,Colors.green];
          } else if (widget.option != widget.correctAnswer &&
              widget.option == state.chosenAnswer) {
            colors = [Colors.red,Colors.red];
          } else {
            //color = Colors.blue;
            colors= [const Color(0xf24d88d6), const Color(0xf22b5088)];
          }
        } else {
          showAnswer = false;
          //color = Colors.blue;
          colors= [const Color(0xf24d88d6), const Color(0xf22b5088)];
        }
      },
      child: InkWell(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
              gradient: RadialGradient(
                center: Alignment(0.0, 0.0),
                radius: 0.5,
                colors: showAnswer ? colors : [const Color(0xf24d88d6), const Color(0xf22b5088)],
                stops: [0.0, 1.0],
                transform: GradientXDTransform(
                    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
              ),
              border: Border.all(width: 3.0, color: const Color(0xf2f0eeee)),
              //color: showAnswer ? color : Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: (10/812)*MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (10/375)*MediaQuery.of(context).size.width,vertical: (10/812)*MediaQuery.of(context).size.height),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(HtmlUnescape().convert(widget.option),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
                SizedBox(height: (10/812)*MediaQuery.of(context).size.height),
              ],
            ),
          ),
        ),
        onTap: () {
          BlocProvider.of<QuizBloc>(context)
              .add(ShowAnswerEvent(widget.option));
        },
      ),
    );
  }
}
