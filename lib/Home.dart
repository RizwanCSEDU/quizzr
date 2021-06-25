import 'package:flutter/cupertino.dart';
import 'package:quizzr/Views/CategoryView.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return CategoryView();
  }
}
