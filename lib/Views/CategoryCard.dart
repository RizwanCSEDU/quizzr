import 'package:adobe_xd/gradient_xd_transform.dart';
import 'package:flutter/material.dart';
import 'package:quizzr/Models/TriviaCategory.dart';
import 'package:quizzr/Views/QuizView.dart';


class CategoryCard extends StatefulWidget {
  final TriviaCategory category;

  CategoryCard({required this.category});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          color: Colors.blue,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              gradient: RadialGradient(
                center: Alignment(0.0, 0.0),
                radius: 0.5,
                colors: [const Color(0xff350865), const Color(0xff0085db)],
                stops: [0.0, 1.0],
                transform: GradientXDTransform(
                    1.0, 0.0, 0.0, 1.0, 0.0, 0.0, Alignment(0.0, 0.0)),
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
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
              child: FittedBox(
                fit:BoxFit.scaleDown,
                child: Text(widget.category.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              )
            )
        ),
      ),

      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => QuizView(widget.category)));
      },
    );
  }
}
