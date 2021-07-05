import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzr/Views/CustomQuizView.dart';

class TakeQuizView extends StatefulWidget {
  @override
  _TakeQuizViewState createState() => _TakeQuizViewState();
}

class _TakeQuizViewState extends State<TakeQuizView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
              child:Text("Take Quiz",
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
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomQuizView(codeController.text.toString())));
                  }
                },
                child: Text("Take")),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: (20/375)*MediaQuery.of(context).size.width,vertical: (10/812)*MediaQuery.of(context).size.height),
          child: Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                controller:codeController ,
                validator: (val) {
                  if (val != null) {
                    return val.isEmpty ? "This field can't be empty." : null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Enter Code",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                ),
              )
          ),
        )
      ],
    );
  }
}
