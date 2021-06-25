import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzr/Models/Participant.dart';

class CustomQuizParticipantCard extends StatefulWidget
{
  final Participant participant;
  CustomQuizParticipantCard(this.participant);
  @override
  _CustomQuizParticipantCardState createState()=> _CustomQuizParticipantCardState();
}

class _CustomQuizParticipantCardState extends State<CustomQuizParticipantCard>{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.green,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: (30/375)*MediaQuery.of(context).size.width,vertical: (20/812)*MediaQuery.of(context).size.height),
        child:Row(
          children: [
            Container(
              width: (200/375)*MediaQuery.of(context).size.width,
              child: Text(widget.participant.email,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.white),overflow: TextOverflow.ellipsis,),
            ),
            Spacer(),
            Text("Score:"+widget.participant.score.toString()+"/"+widget.participant.total.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.white),),
          ],
        ),
      ),
    );
  }
}