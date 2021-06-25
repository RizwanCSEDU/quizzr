import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SubmittedSuccessfullyView extends StatefulWidget{
  final String id;
  SubmittedSuccessfullyView(this.id);
  @override
  _SubmittedSuccessfullyViewState createState()=>_SubmittedSuccessfullyViewState();
}

class _SubmittedSuccessfullyViewState extends State<SubmittedSuccessfullyView>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
          body:Center(
            child: Column(
              children: [
                SizedBox(
                  height: (100/812)*MediaQuery.of(context).size.height,
                ),
                SizedBox(
                  height: (200/812)*MediaQuery.of(context).size.height,
                  child: new Image.asset(
                    "images/checked.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: (30/812)*MediaQuery.of(context).size.height,
                ),
                Text(
                  "Submitted Successfully",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: (30/812)*MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: (85/375)*MediaQuery.of(context).size.width,vertical: (85/812)*MediaQuery.of(context).size.height),
                  child: GestureDetector(
                    child: Container(
                      height: (50/812)*MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "Copy Quiz Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied quiz code')));
                    },
                  ),
                ),
                SizedBox(
                  height: (50/812)*MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: EdgeInsets.all(25),
                  child: GestureDetector(
                    child: Container(
                      height: (50/812)*MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "Return Home",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}