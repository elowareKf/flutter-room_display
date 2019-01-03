import 'package:flutter/material.dart';
import 'package:room_display/screens/homeScreen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Room Manager",
      home: HomeScreen(),
    );
  }
}
