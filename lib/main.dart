import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:questioner/bloc/questions_bloc/questions_bloc.dart';
import 'package:questioner/screens/form_screen.dart';
import 'package:questioner/screens/home_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          BlocProvider(create: (_) => QuestionsBloc())
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
