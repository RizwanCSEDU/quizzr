import 'package:quizzr/Authentication_Bloc/Authentication_bloc.dart';
import 'package:quizzr/Authentication_Bloc/Authentication_state.dart';
import 'package:quizzr/Categories_Bloc/Categories_bloc.dart';
import 'package:quizzr/CreatedQuiz_Bloc/CreatedQuiz_bloc.dart';
import 'package:quizzr/CustomQuizParticipants_Bloc/CustomQuizParticipants_bloc.dart';
import 'package:quizzr/CustomQuiz_Bloc/CustomQuiz_bloc.dart';
import 'package:quizzr/Home.dart';
import 'package:quizzr/QuizInput_Bloc/QuizInput_bloc.dart';
import 'package:quizzr/Quiz_Bloc/Quiz_bloc.dart';
import 'package:quizzr/Services/API.dart';
import 'package:quizzr/Services/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizzr/Services/CustomQuizHelper.dart';
import 'CustomQuizParticipation_Bloc/CustomQuizParticipation_bloc.dart';
import 'Views/AuthenticateView.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiRepositoryProvider(
    providers: [
      RepositoryProvider<Authentication>(
        create: (context) => Authentication(),
      ),
      RepositoryProvider<API>(
        create: (context) =>API(),
      ),
      RepositoryProvider<CustomQuizHelper>(
        create: (context) =>CustomQuizHelper(),
      ),
    ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            lazy: false,
            create: (context)=> AuthenticationBloc(context.read<Authentication>()),
          ),
          BlocProvider<CategoriesBloc>(
            lazy: false,
            create: (context)=> CategoriesBloc(context.read<API>()),
          ),
          BlocProvider<CreatedQuizBloc>(
            lazy: false,
            create: (context)=> CreatedQuizBloc(context.read<CustomQuizHelper>()),
          ),
          BlocProvider<QuizBloc>(
              lazy: false,
              create: (context)=>QuizBloc(context.read<API>())
          ),
          BlocProvider<CustomQuizBloc>(
              lazy: false,
              create: (context)=>CustomQuizBloc(context.read<CustomQuizHelper>())
          ),
          BlocProvider<QuizInputBloc>(
              lazy: false,
              create: (context)=>QuizInputBloc(context.read<CustomQuizHelper>())
          ),
          BlocProvider<CustomQuizParticipantsBloc>(
              lazy: false,
              create: (context)=>CustomQuizParticipantsBloc(context.read<CustomQuizHelper>())
          ),
          BlocProvider<CustomQuizParticipationBloc>(
              lazy: false,
              create: (context)=>CustomQuizParticipationBloc(context.read<CustomQuizHelper>())
          ),

        ],
        child: MaterialApp(
          home: MyApp(),
        )
    ),
  ),

  );
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc,AuthenticationState>(
      builder:(context,state){
        if(state is Authenticated)
        {
          print('Home View');
          return Home();
        }
        else{

          return AuthenticateView();
        }
      },

    );
  }
}