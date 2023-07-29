import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/home_screen.dart';
import 'package:flutter_todo/.env.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Configure.AppName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
