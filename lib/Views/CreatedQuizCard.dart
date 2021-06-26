import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_event.dart';
import 'package:quizzr/Models/CustomQuizDetails.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_bloc.dart';
import 'package:quizzr/Views/CustomQuizParticipantsView.dart';

class CreatedQuizCard extends StatefulWidget {
  final CustomQuizDetails details;

  CreatedQuizCard({required this.details});

  @override
  _CreatedQuizCardState createState() => _CreatedQuizCardState();
}

class _CreatedQuizCardState extends State<CreatedQuizCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          //color: Colors.blue[700],
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
              padding: EdgeInsets.only(left: (10/375)*MediaQuery.of(context).size.width, top: (20/812)*MediaQuery.of(context).size.height, bottom: (100/812)*MediaQuery.of(context).size.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: (250/375)*MediaQuery.of(context).size.width,
                    child: Text(
                      widget.details.title,
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
                                    0.15,
                                child: ListView(children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Clipboard.setData(
                                          ClipboardData(text: widget.details.id));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('Copied quiz code')));
                                    },
                                    child: Text("Copy Quiz Code",
                                        style: TextStyle(
                                            color: Colors.blue[700], fontSize: 15)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      BlocProvider.of<CreatedQuizBloc>(context)
                                          .add(DeleteQuiz(widget.details));
                                    },
                                    child: Text("Delete Quiz",
                                        style: TextStyle(
                                            color: Colors.blue[700], fontSize: 15)),
                                  ),
                                ]),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomQuizParticipantsView(widget.details)));
      },
    );
  }
}
