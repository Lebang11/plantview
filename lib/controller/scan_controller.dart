/**
 * Import the dart:math library for mathematical operations
 */
import 'dart:math';

/**
 * Import the camera library for camera functionality
 */
import 'package:camera/camera.dart';

/**
 * Import the GetX state manager library for state management
 */
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

/**
 * Import the permission handler library for handling permissions
 */
import 'package:permission_handler/permission_handler.dart';

/**
 * Import the Flutter TFLite library for machine learning models
 */
import 'package:flutter_tflite/flutter_tflite.dart';

/**
 * ScanController class that extends GetxController
 */
class ScanController extends GetxController {
  /**
   * Late initialization of the CameraController
   */
  late CameraController cameraController;

  /**
   * Late initialization of the list of CameraDescription
   */
  late List<CameraDescription> cameras;

  /**
   * Flag to indicate if the camera is paused
   */
  bool isPaused = false;

  /**
   * Observable variable to track if the camera is initialized
   */
  var isCameraInitialized = false.obs;

  /**
   * Variable to count the number of camera frames
   */
  var cameraCount = 0;

  /**
   * Variables to store the object detection results
   */
  var x, y, w, h = 0.0;
  var label = "";
  var confidence = 0.0;

  /**
   * Override the onInit method to initialize the camera and TFLite model
   */
  @override
  void onInit() {
    super.onInit();
    initCamera();
    initTflite();
  }

  /**
   * Override the dispose method to dispose of the camera controller
   */
  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  /**
   * Initialize the camera
   */
  initCamera() async {
    /**
     * Request camera permission and check if it's granted
     */
    if (await Permission.camera.request().isGranted) {
      /**
       * Get the list of available cameras
       */
      cameras = await availableCameras();

      /**
       * Initialize the camera controller with the first camera
       */
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );

      /**
       * Initialize the camera and start the image stream
       */
      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 20 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCameraInitialized(true);
      update();
    } else {
      print("Permission denied");
    }
  }

  /**
   * Pause the camera preview
   */
  pausePreview() async {
    await cameraController.pausePreview();
    isPaused = true;
  }

  /**
   * Start the camera preview
   */
  startPreview() async {
    await cameraController.resumePreview();
    isPaused = false;
  }

  /**
   * Initialize the TFLite model
   */
  initTflite() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 2,
      useGpuDelegate: false,
    );
  }

  /**
   * Run the object detection model on a camera frame
   */
  objectDetector(CameraImage image) async {
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 3,
      rotation: 90,
    );

    if (detector != null) {
      var ourDetectedObject = detector.first;
      label = ourDetectedObject['label'];
      confidence = ourDetectedObject['confidence'];
    }
  }
}