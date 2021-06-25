import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final int index;
  final int totalNumberOfQuestions;

  QuestionCard(this.question, this.index, this.totalNumberOfQuestions);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
            "Question" +
                (widget.index + 1).toString() +
                "/" +
                widget.totalNumberOfQuestions.toString(),
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        SizedBox(height: 10),
        Divider(
          thickness: (2/812)*MediaQuery.of(context).size.height,
          indent: (10/375)*MediaQuery.of(context).size.width,
          endIndent: (10/375)*MediaQuery.of(context).size.width,
          color: Colors.black87,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: (10/375)*MediaQuery.of(context).size.width,vertical: (10/812)*MediaQuery.of(context).size.height),
            child: Container(
              child: Text(HtmlUnescape().convert(widget.question),
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            )),
        SizedBox(height: (10/812)*MediaQuery.of(context).size.height),
      ],
    );
  }
}
