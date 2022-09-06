import 'package:flutter/material.dart';
import 'package:your_theater/screens/login.dart';
import 'package:your_theater/screens/signup.dart';
import 'package:your_theater/screens/home_screen.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie API Demo App',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SignUp(),
          '/login': (context) => const Login(),
          '/home': (context) => const HomeScreen(),
        });
  }
}
