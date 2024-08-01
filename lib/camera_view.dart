import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.high);
      await controller.initialize();
      setState(() {
        isControllerInitialized = true;
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    if (isControllerInitialized) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isControllerInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Farm Analysis')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Farm Analysis')),
      body: CameraPreview(controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await controller.startVideoRecording();
            await Future.delayed(Duration(seconds: 5)); // Record for 5 seconds
            XFile video = await controller.stopVideoRecording();
            analyzeVideo(video); // Implement this function for video analysis
          } catch (e) {
            print("Error during video recording: $e");
          }
        },
        child: Icon(Icons.videocam),
      ),
    );
  }

  void analyzeVideo(XFile video) {
    // Implement your video analysis logic here
  }
}
