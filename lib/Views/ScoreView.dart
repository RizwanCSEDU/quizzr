import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizzr/Views/CategoryView.dart';

class ScoreView extends StatefulWidget {
  final int score;
  final int total;

  ScoreView(this.score, this.total);

  @override
  _ScoreViewState createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: new IconThemeData(color: Colors.black),
              brightness: Brightness.light,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                children: [
                  Text(
                    "You Scored",
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  SizedBox(
                    height: (30/812)*MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    height: (200/812)*MediaQuery.of(context).size.height,
                    child: new Image.asset(
                      "images/trophy.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: (30/812)*MediaQuery.of(context).size.height,
                  ),
                  Text(
                    widget.score.toString() + "/" + widget.total.toString(),
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 50),
                  ),
                  SizedBox(
                    height: (30/812)*MediaQuery.of(context).size.height,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (50/375)*MediaQuery.of(context).size.width,vertical: (25/812)*MediaQuery.of(context).size.height),
                    child: GestureDetector(
                      child: Container(
                        height: (50/812)*MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: RadialGradient(
                            center: Alignment(0.0, 0.0),
                            radius: 0.5,
                            colors: [const Color(0xf24d88d6), const Color(0xf22b5088)],
                            stops: [0.0, 1.0],
                            transform: GradientXDTransform(
                                1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        /*int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 2;
                    });*/
                        //Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )),
        onWillPop: () async => false,
    );
  }
}
