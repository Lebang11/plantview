import 'package:flutter/material.dart';
import 'package:plantview/views/camera_view.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm Analysis App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CameraView(),
    );
  }
}
