import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:quizzr/Views/QuizInputView.dart';

class InitialQuizInputView extends StatefulWidget{

  @override
  _InitialQuizInputViewState createState()=> _InitialQuizInputViewState();
}

class _InitialQuizInputViewState extends State<InitialQuizInputView>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  int numberOfQuestions = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text("Create Quiz",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          elevation: 0,
          iconTheme: new IconThemeData(color: Colors.black),
          brightness: Brightness.light,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() == true) {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizInputView(numberOfQuestions, titleController.text.toString())));
                  }
                },
                child: Text("Next"))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: (10/812)*MediaQuery.of(context).size.height),
          children: [
            Center(
                child: Padding(
                  padding: EdgeInsets.only(left: (20/375)*MediaQuery.of(context).size.width, right: (20/375)*MediaQuery.of(context).size.width, top: (50/812)*MediaQuery.of(context).size.height),
                  child: Column(
                    children: [
                      Text("Number of Questions",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                      NumberPicker(
                        minValue: 1,
                        maxValue: 10,
                        value: numberOfQuestions,
                        axis: Axis.horizontal,
                        onChanged: (value)=> setState(()=>numberOfQuestions = value),
                      ),
                      SizedBox(
                        height: (15/812)*MediaQuery.of(context).size.height,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          autofocus: true,
                          controller:titleController ,
                          validator: (val) {
                            if (val != null) {
                              return val.isEmpty ? "This field can't be empty." : null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Title",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        )
    );
  }
}