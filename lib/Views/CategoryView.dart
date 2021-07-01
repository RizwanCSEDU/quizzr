import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizzr/Categories_Bloc/Categories_bloc.dart';
import 'package:quizzr/Categories_Bloc/Categories_event.dart';
import 'package:quizzr/Categories_Bloc/Categories_state.dart';
import 'package:quizzr/Services/Authentication.dart';
import 'package:quizzr/Views/CategoryCard.dart';
import 'package:quizzr/Views/CreatedQuizView.dart';
import 'package:quizzr/Views/CustomQuizParticipationView.dart';
import 'package:quizzr/Views/InitialQuizInputView.dart';
import 'package:quizzr/Views/TakeQuizView.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(LoadCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e2e2),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Categories",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25)),
        iconTheme: new IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        actions: [
          GestureDetector(
            child: Icon(Icons.exit_to_app),
            onTap: () async {
              await RepositoryProvider.of<Authentication>(context).signOut();
            },
          ),
        ],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedCategoriesState) {
            return new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                      child: new ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            (5 / 375) * MediaQuery.of(context).size.width,
                        vertical:
                            (5 / 812) * MediaQuery.of(context).size.height),
                    itemCount: state.categories.triviaCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new CategoryCard(
                          category: state.categories.triviaCategories[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: (20 / 812) * MediaQuery.of(context).size.height,
                    ),
                  )),
                ]);
          } else {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (10 / 375) * MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  SizedBox(
                    height: (30 / 812) * MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    height: (200 / 812) * MediaQuery.of(context).size.height,
                    child: new Image.asset(
                      "images/error.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: (70 / 812) * MediaQuery.of(context).size.height,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Ooops!",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 38),
                    ),
                  ),
                  SizedBox(
                    height: (50 / 812) * MediaQuery.of(context).size.height,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "There was an error!",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Make sure you're connected to the internet",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: (130 / 812) * MediaQuery.of(context).size.height,
                  ),
                  TextButton(
                      onPressed: () {
                        BlocProvider.of<CategoriesBloc>(context)
                            .add(LoadCategoriesEvent());
                      },
                      child: Text(
                        "Retry",
                        style: TextStyle(color: Colors.red, fontSize: 20),
                      )),
                ],
              ),
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).copyWith().size.height * 0.15,
                  child: ListView(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      0.4,
                                  child: InitialQuizInputView(),
                                );
                              });
                        },
                        child: Text("Create Quiz",
                            style: TextStyle(color: Colors.blue, fontSize: 15)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        0.25,
                                    child: TakeQuizView(),
                                  );
                                });
                          },
                          child: Text("Take Quiz",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15))),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(
              top: (65 / 812) * MediaQuery.of(context).size.height),
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.list_alt_rounded),
                  SizedBox(
                    width: (10 / 375) * MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "See Created Quiz",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatedQuizView()));
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.list_alt_rounded),
                  SizedBox(
                    width: (10 / 375) * MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "See Participation Record",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomQuizParticipationView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
