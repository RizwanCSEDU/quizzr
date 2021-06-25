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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text("Take Quiz",
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
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomQuizView(codeController.text.toString())));
                  }
                },
                child: Text("Take"))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: (20/812)*MediaQuery.of(context).size.height),
          children: [
            Center(
                child: Padding(
                  padding: EdgeInsets.only(left: (20/375)*MediaQuery.of(context).size.width, right: (20/375)*MediaQuery.of(context).size.width, top: (50/812)*MediaQuery.of(context).size.height),
                  child: Column(
                    children: [
                      Form(
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
