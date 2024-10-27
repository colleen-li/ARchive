import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _Test();
}

class _Test extends State<Test> {
  late ARKitController arkitController;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('AR Text Tool'),
      ),
      child: Stack(
        children: [
          ARKitSceneView(
            showFeaturePoints: false,
            enableTapRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
            planeDetection: ARPlaneDetection.horizontal,
            environmentTexturing: ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              onPressed: _addText,
              child: Icon(CupertinoIcons.textformat),
            ),
          ),
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (nodes) => onNodeTapHandler(nodes);
  }

  void onNodeTapHandler(List<ARKitTestResult> nodesList) {
    if (nodesList.isNotEmpty) {
      final tappedNode = nodesList.first;
      _addTextAtPosition(tappedNode.worldTransform);
    }
  }

  void _addTextAtPosition(Matrix4 transform) {
    final position = vector.Vector3(
      transform.getTranslation().x,
      transform.getTranslation().y + 0.1,
      transform.getTranslation().z,
    );

    final textNode = ARKitNode(
      geometry: ARKitText(
        text: "Hello AR!",
        extrusionDepth: 1,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(CupertinoColors.activeBlue),
          ),
        ],
      ),
      position: position,
    );

    arkitController.add(textNode);
    debugPrint("Text added at position: $position");
  }

  void _addText() {
    debugPrint("Text button tapped! Tap on the screen to place text.");
  }
}
