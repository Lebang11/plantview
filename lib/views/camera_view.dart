import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plantview/controller/scan_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, String>> cropInformation = {
      "Maize": {
        "Description": "Maize, also known as corn, is a staple cereal crop grown for its kernels, which can be consumed directly, processed into various products, or used as animal feed.",
        "Growth Stages": "Germination (5-10 days), Vegetative (20-60 days), Tasseling & Pollination (60-100 days), Grain Filling & Maturity (100-140 days)",
        "Ideal Growing Conditions": "Soil: Well-drained, loamy; pH: 5.8 - 7.0; Temperature: 18°C - 27°C (64°F - 81°F); Water: 500-800mm rainfall",
        "Common Diseases": "Maize Streak Virus, Rust, Leaf Blight",
        "Fertilization": "Nitrogen: 120-160 kg/ha, Phosphorus: 60-80 kg/ha, Potassium: 40-60 kg/ha",
        "Pests": "Fall Armyworm, Corn Borer",
        "Guide": "WNUNq4QJ-CM"
      },
      "Tomatoes": {
        "Description": "Tomatoes are a versatile fruit commonly used in cooking, known for their juicy texture and rich flavor. They are cultivated in various climates and can be consumed fresh or processed.",
        "Growth Stages": "Germination (5-10 days), Seedling (2-4 weeks), Vegetative (4-6 weeks), Flowering (1-3 weeks), Fruit Set & Maturation (4-6 weeks)",
        "Ideal Growing Conditions": "Soil: Well-drained, sandy loam; pH: 6.0 - 6.8; Temperature: 18°C - 29°C (64°F - 84°F); Water: Regular, consistent moisture",
        "Common Diseases": "Late Blight, Fusarium Wilt, Blossom End Rot",
        "Fertilization": "Nitrogen: 100-150 kg/ha, Phosphorus: 50-70 kg/ha, Potassium: 100-200 kg/ha",
        "Pests": "Aphids, Tomato Hornworm",
        "Guide": "FSFBPtRO4HU"
      },
      "Carrots": {
        "Description": "Carrots are a root vegetable known for their crisp texture and sweet flavor. They are rich in beta-carotene and are commonly eaten raw, cooked, or juiced.",
        "Growth Stages": "Germination (10-20 days), Leaf Development (20-60 days), Root Development & Maturation (60-120 days)",
        "Ideal Growing Conditions": "Soil: Loose, sandy loam; pH: 6.0 - 6.8; Temperature: 15°C - 21°C (59°F - 70°F); Water: Consistent moisture, not waterlogged",
        "Common Diseases": "Alternaria Leaf Blight, Powdery Mildew",
        "Fertilization": "Nitrogen: 50-100 kg/ha, Phosphorus: 40-60 kg/ha, Potassium: 100-150 kg/ha",
        "Pests": "Carrot Fly, Aphids",
        "Guide": "784hW6J1D70"
      },
      "Grapes": {
        "Description": "Grapes are small, round fruits that grow in clusters and are used in making wine, juice, raisins, or consumed fresh. They come in various colors, including green, red, and black.",
        "Growth Stages": "Bud Break (Spring), Flowering (Late Spring), Fruit Set (Early Summer), Veraison (Late Summer), Harvest (Autumn)",
        "Ideal Growing Conditions": "Soil: Well-drained, fertile soils; pH: 5.5 - 7.0; Temperature: 15°C - 30°C (59°F - 86°F); Water: Moderate, avoid excess moisture",
        "Common Diseases": "Powdery Mildew, Downy Mildew, Botrytis Bunch Rot",
        "Fertilization": "Nitrogen: 50-100 kg/ha, Phosphorus: 20-40 kg/ha, Potassium: 50-100 kg/ha",
        "Pests": "Grape Berry Moth, Leafhoppers",
        "Guide": "8Ik7b6UcDP8"

      }
    };

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.seedling, color: Colors.green[900],),
            Text(
              'PlantView',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        
        elevation: 0.0,
      ),
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: (controller) {
          var crop = controller.label.split(" ").length > 1?  controller.label.split(" ")[1] :'';
           // The detected crop name
          var info = cropInformation[crop];
          return controller.isCameraInitialized.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.green,
                                width: 4.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: controller.isPaused
                                  ? Container(
                                      color: Colors.black54,
                                      child: Center(
                                        child: Text(
                                          "Preview Paused",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  : CameraPreview(controller.cameraController),
                            ),
                          ),
                          if (controller.label.isNotEmpty)
                            Positioned(
                              top: (controller.y ?? 0.0) * 700.0,
                              right: (controller.x ?? 0.0) * 500.0,
                              child: Container(
                                width: (controller.w ?? 1.0) *
                                    100 *
                                    context.width /
                                    100,
                                height: (controller.h ?? 1.0) *
                                    100 *
                                    context.height /
                                    100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.green, width: 4.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        controller.label,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                     Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 6),
                                      child: Text(
                                        "${(controller.confidence * 100).toStringAsFixed(0)}% confidence",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(controller.isPaused
                                ? Icons.play_arrow
                                : Icons.pause),
                            iconSize: 45,
                            color: Colors.green,
                            onPressed: () {
                              if (controller.isPaused) {
                                controller.startPreview();
                              } else {
                                controller.pausePreview();
                              }
                            },
                          ),
                        ],
                      ),
                      
                      
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: info != null
                              ? [
                                  Center(
                                    child: Text(
                                      crop,
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    info["Description"]!,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(221, 77, 77, 77),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Growth Stages",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    info["Growth Stages"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Ideal Growing Conditions",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    info["Ideal Growing Conditions"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Common Diseases",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    info["Common Diseases"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Fertilization",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    info["Fertilization"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Pests",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    info["Pests"]!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                        Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Growing Guide",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: info["Guide"]!, // Replace with actual video ID
                                flags: YoutubePlayerFlags(
                                  autoPlay: false,
                                  mute: false,
                                ),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            ),
                            // Additional videos can be added here
                          ],
                        ),
                                ]
                              : [
                                  Text(
                                    "No information available for $crop",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              : const Center(
                  child: Text("Loading Preview"),
                );
        },
      ),
    );
  }
}
