import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_app/Pomodoro_app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Promodoro App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PomodoroApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
