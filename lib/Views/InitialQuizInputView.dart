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
     return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child:Text("Create Quiz",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)
              ),
            ),
            Spacer(),
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
                child: Text("Next")),
          ],
        ),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: (10/812)*MediaQuery.of(context).size.height,horizontal:(20/375)*MediaQuery.of(context).size.width),
          child:Form(
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
          ) ,
        )
      ],
    );
  }
}