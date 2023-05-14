import 'package:flutter/material.dart';
import 'package:frontend/screens/layout.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ashesi Verse',
      home: Layout()
    );
  }
}