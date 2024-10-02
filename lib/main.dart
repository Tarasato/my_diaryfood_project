// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_project/views/splash_screen_ui.dart';

void main() {
  runApp( 
    MyDiaryfood()
  );
}

class MyDiaryfood extends StatefulWidget {
  const MyDiaryfood({super.key});

  @override
  State<MyDiaryfood> createState() => _MyDiaryfoodState();
}

class _MyDiaryfoodState extends State<MyDiaryfood> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  SplashScreenUI(),
      theme: ThemeData(
      textTheme: GoogleFonts.kanitTextTheme(
        Theme.of(context).textTheme
      )
        ),
      );
  }
}