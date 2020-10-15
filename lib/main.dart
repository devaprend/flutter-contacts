import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Contact",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          hintColor: Colors.black54,
          primarySwatch: Colors.green,
          accentColor: Colors.green),
      home: HomePage(),
    );
  }
}

void main() => runApp(MyApp());
