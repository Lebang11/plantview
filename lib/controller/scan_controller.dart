import 'dart:math';

import 'package:camera/camera.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class ScanController extends GetxController {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isPaused = false;

  var isCameraInitialized = false.obs;
  var cameraCount =0;

  var x,y,w,h = 0.0;
  var label = "";
  var confidence = 0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCamera();
    initTflite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }
  
  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
          cameras[0],
         ResolutionPreset.medium);

         await cameraController.initialize()
                .then((value) {
                  
                    cameraController.startImageStream((image) {
                      cameraCount ++;
                      if (cameraCount % 20 ==0) {
                        cameraCount = 0;
                        objectDetector(image);
                      }
                      update();
                    } );                  
                })
         ;
         isCameraInitialized(true);
          update();
    } else {
      print("Permission denied");
    }
  }

  pausePreview() async {
    await cameraController.pausePreview();
    isPaused = true;
  }

  startPreview( ) async {
    await cameraController.resumePreview();
    isPaused = false;
  }

  initTflite() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite", 
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 2,
      useGpuDelegate: false
      );
  }

  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {

      return e.bytes;
    }).toList(),
    asynch: true,
    imageHeight: image.height,
    imageWidth: image.width,
    imageMean:  127.5,
    imageStd: 127.5,
    numResults: 3,
    rotation: 90    
    );

    if (detector != null) {
      var ourDetectedObject = detector.first;
      label = ourDetectedObject['label'];
      confidence = ourDetectedObject['confidence'];
     

    }

  }

}