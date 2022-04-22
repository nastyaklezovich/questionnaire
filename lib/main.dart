import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questioner/bloc/questions_bloc/questions_bloc.dart';
import 'package:questioner/resources/api_provider.dart';
import 'package:questioner/resources/api_repository.dart';
import 'package:questioner/screens/form_screen.dart';
import 'package:questioner/screens/home_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          Provider(create: (context) => ApiProvider()),
          Provider(create:(context) => ApiRepository(context.read())),
          Provider(create:(context) => QuestionsBloc(context.read())),
        ],
        child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'Questionnaire',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomePage(),
            '/form': (context) => const FormPage(),
          },
        );
  }
}
