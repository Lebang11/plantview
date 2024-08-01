import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plantview/controller/scan_controller.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        title: Text('Crop Analysis'),
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          return controller.isCameraInitialized.value ? 
          Column(
            children: [
              Stack(
                children: [
                  CameraPreview(controller.cameraController),
                  Positioned(
                    top: (controller?.y ?? 0.0) * 700.0,
                    right: (controller?.y ?? 0.0) * 500.0,
                    child: Container(
                      width: (controller?.w ?? 1.0)*100 * context.width / 100,
                      height: (controller?.h ?? 1.0)*100 * context.height / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green, width: 4.0)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Text(controller.label))
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Text(controller.label, style: TextStyle(
                fontSize: 50,
                color: Colors.amber
              ),),
              Text("Confidence: " + (controller.confidence*100).toStringAsFixed(0) + "%", style: TextStyle(
                fontSize: 50
              ),)
            ],
          )
          : const Center(child: Text("Loading Preview"),);
        }
      ),
    );
  }
}