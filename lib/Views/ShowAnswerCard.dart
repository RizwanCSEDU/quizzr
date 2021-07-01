import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzr/Models/Question.dart';

class ShowAnswerCard extends StatefulWidget{
  final Question question;
  final int index;
  ShowAnswerCard(this.question,this.index);
  @override
  _ShowAnswerCardState createState()=> _ShowAnswerCardState();
}

class _ShowAnswerCardState extends State<ShowAnswerCard>{

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            widget.index.toString()+". "+widget.question.question,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Text(
            "ans: "+widget.question.correctAnswer,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
        )
      ],
    );

  }
}