import 'package:flutter/material.dart';
import 'package:newz_app/Home.dart';
import 'package:newz_app/Login/LoGin.dart';
import 'package:newz_app/newsfeed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:ThemeData.dark(),
      home: HomePage(),
    );
  }
}


