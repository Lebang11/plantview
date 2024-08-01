import 'package:flutter/material.dart';
import 'camera_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Analysis App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CameraView(),
    );
  }
}
