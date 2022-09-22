import 'package:flutter/material.dart';
import 'package:thuc_tap/Database/database.dart';
import 'package:thuc_tap/Screen/Begin/Begin_screen.dart';
import 'package:thuc_tap/Screen/Interview/interview_screen.dart';
import 'package:thuc_tap/constant.dart';

import 'Screen/DashBoard/Home.dart';
import 'Screen/Login/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primaryColor: mPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BeginScreen(),
      routes: {
        '/home': (context) => Home(),
        '/interview': (context) => InterviewScreen(),
      },
    );
  }
}

