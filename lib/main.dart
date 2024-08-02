/**
 * Import the necessary libraries for the main application
 */
import 'package:flutter/material.dart';
import 'package:plantview/views/camera_view.dart';
import 'package:camera/camera.dart';

/**
 * A list of available camera descriptions
 */
List<CameraDescription>? cameras;

/**
 * The main function of the application
 */
void main() async {
  /**
   * Ensure that the Flutter framework is initialized
   */
  WidgetsFlutterBinding.ensureInitialized();

  /**
   * Get a list of available cameras on the device
   */
  cameras = await availableCameras();

  /**
   * Run the MyApp widget as the root of the application
   */
  runApp(MyApp());
}

/**
 * The MyApp widget is the root of the application
 */
class MyApp extends StatelessWidget {
  @override
  /**
   * Build the UI for the MyApp widget
   */
  Widget build(BuildContext context) {
    return MaterialApp(
      /**
       * Disable the debug banner
       */
      debugShowCheckedModeBanner: false,

      /**
       * Set the title of the application
       */
      title: 'Farm Analysis App',

      /**
       * Set the theme of the application
       */
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      /**
       * Set the home page of the application to the CameraView
       */
      home: CameraView(),
    );
  }
}