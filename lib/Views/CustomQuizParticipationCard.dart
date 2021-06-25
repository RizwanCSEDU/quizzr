import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzr/Models/Participation.dart';

class CustomQuizParticipationCard extends StatefulWidget{
  final Participation participationDetails;
  CustomQuizParticipationCard(this.participationDetails);
  @override
  _CustomQuizParticipationCardState createState()=> _CustomQuizParticipationCardState();
}

class _CustomQuizParticipationCardState extends State<CustomQuizParticipationCard>{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //color: Colors.blue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment(1.13, 0.26),
                end: Alignment(-0.69, -1.36),
                colors: [const Color(0xf24279e7), const Color(0xf240236d)],
                stops: [0.0, 1.0],
              ),
              border: Border.all(width: 3.0, color: const Color(0xf2f0eeee)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x27000000),
                  offset: Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: (10/375)*MediaQuery.of(context).size.width, top: (20/812)*MediaQuery.of(context).size.height, bottom: (60/812)*MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: (250/375)*MediaQuery.of(context).size.width,
                        child: Text(
                          widget.participationDetails.quizDetails.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
                                        0.10,
                                    child: Column(children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Clipboard.setData(
                                              ClipboardData(text: widget.participationDetails.quizDetails.id));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  content: Text('Copied quiz code')));
                                        },
                                        child: Text("Copy Quiz Code",
                                            style: TextStyle(
                                                color: Colors.blue, fontSize: 15)),
                                      ),
                                    ]),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Text(
                    "Score: "+widget.participationDetails.score.toString()+"/"+widget.participationDetails.total.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ],
              )
            ),
          )),
      onTap: () {

      },
    );
  }
}