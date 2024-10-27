import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;


class ArTesting extends StatefulWidget {
  const ArTesting({super.key});

  @override
  State<ArTesting> createState() => _ArTesting();
}

class _ArTesting extends State<ArTesting> {
  late ARKitController arkitController;
  ARKitPlane? plane;
  ARKitNode? planeNode;
  String? anchorId;

  Offset? initialFocalPoint;
  vector.Vector3? initialPlanePosition;

  bool planePlaced = false;
  DateTime? lastUpdateTime;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
          child: GestureDetector(
              // onScaleStart: _onScaleStart,
              // onScaleUpdate: _onScaleUpdate,
              child: ARKitSceneView(
        showFeaturePoints: true,
        onARKitViewCreated: onARKitViewCreated,
        planeDetection: ARPlaneDetection.horizontalAndVertical,
        environmentTexturing:
            ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
      )));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    this.arkitController.onARTap = (nodes) => onNodeTapHandler(nodes);
  }

  void onNodeTapHandler(List<ARKitTestResult> nodesList) {
    if (nodesList.isNotEmpty) {
      final tappedNode = nodesList.first;

      // if (tappedNode.anchor is ARKitPlaneAnchor) {
      //   _addPlaneAtPosition(tappedNode.worldTransform, tappedNode.anchor as ARKitPlaneAnchor);
      // }

      _addPlaneAtPosition(tappedNode.worldTransform);
      
    }
  }

  void _addPlaneAtPosition(Matrix4 transform) {

    // Extract the positions from the tapped point
    final position = vector.Vector3(
      transform.getTranslation().x,
      transform.getTranslation().y,
      transform.getTranslation().z,
    );

    // Normalize the plane
    final normal = vector.Vector3(0, 1, 0);
    position.add(normal.normalized() * 0.1);

    ARKitMaterial imageMaterial = ARKitMaterial(
      diffuse: ARKitMaterialProperty.image('assets/images/background.jpg'),
      transparency: 1.0,
    );

    // Define the plane size
    plane = ARKitPlane(
      width: 1.0,
      height: 1.0,
      materials: [imageMaterial],
    );

    // Normal rotation
    // final rotationMatrix = transform.getRotation();
    // final quaternion = vector.Quaternion.fromRotation(rotationMatrix);
    // final rotationVector4 = vector.Vector4(quaternion.x, quaternion.y, quaternion.z, quaternion.w);

    // final rotation = vector.Vector4(anchor.transform[0], anchor.transform[5], anchor.transform[10], 0);

    final rotation = vector.Vector4(1,1,1,1);

    // Define plane position
    planeNode = ARKitNode(
      geometry: plane,
      position: position,
      rotation:  rotation,
    );

    arkitController.add(planeNode!);
    debugPrint("Plane added at wall location with ID: ${planeNode!.name}");
    debugPrint("Adding plane at: $position");
    debugPrint("Plane size: width=${plane!.width.value}, height=${plane!.height.value}");
    debugPrint("$rotation");
  }

  // void _onScaleStart(ScaleStartDetails details) {
  //   initialFocalPoint = details.focalPoint;
  //   if (planeNode != null) {
  //     initialPlanePosition = planeNode!.position;
  //   }
  // }

  // void _handleAddAnchor(ARKitAnchor anchor) {
  //   if (anchor is ARKitPlaneAnchor) {
  //     _addPlane(arkitController, anchor);
  //     planePlaced = true;
  //     debugPrint("Created!");
  //   }
  // }

  // void _handleUpdateAnchor(ARKitAnchor anchor) {
  //   // Throttle updates to once every 100 ms
  //   final now = DateTime.now();
  //   if (lastUpdateTime != null && now.difference(lastUpdateTime!).inMilliseconds < 100) {
  //     return;
  //   }
  //   lastUpdateTime = now;

  //   if (anchor.identifier != anchorId || anchor is! ARKitPlaneAnchor) {
  //     return;
  //   }
  //   if (planeNode != null) {
  //     planeNode?.position = vector.Vector3(anchor.center.x, 0, anchor.center.z);
  //     plane?.width.value = anchor.extent.x;
  //     plane?.height.value = anchor.extent.z;
  //   }
  // }

  // void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
  //   anchorId = anchor.identifier;

  //   ARKitMaterial imageMaterial = ARKitMaterial(
  //     diffuse: ARKitMaterialProperty.image('assets/images/background.jpg'), // Ensure this is optimized
  //     transparency: 1.0,
  //   );

  //   plane = ARKitPlane(
  //     width: anchor.extent.x,
  //     height: anchor.extent.z,
  //     materials: [imageMaterial],
  //   );

  //   planeNode = ARKitNode(
  //     geometry: plane,
  //     position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
  //     rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
  //   );

  //   controller.add(planeNode!, parentNodeName: anchor.nodeName);
  //   debugPrint("Plane added with ID: ${planeNode!.name}");
  // }

  // void _onScaleStart(ScaleStartDetails details) {
  //   initialFocalPoint = details.focalPoint;
  //   if (planeNode != null) {
  //     initialPlanePosition = planeNode!.position;
  //   }
  // }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null && initialPlanePosition != null) {
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;

      planeNode!.position =
          initialPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }
}
