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

    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    this.arkitController.onNodeTap = (nodes) => onNodeTapHandler(nodes);
  }

  void onNodeTapHandler(List<String> nodesList) {
    if (nodesList.isNotEmpty) {
      final name = nodesList.first;

      arkitController.update(name, materials: [
        ARKitMaterial(
          lightingModelName: ARKitLightingModel.physicallyBased,
          diffuse: ARKitMaterialProperty.color(Colors.yellow[600]!),
          metalness: ARKitMaterialProperty.value(1),
          roughness: ARKitMaterialProperty.value(0),
        )
      ]);
    }
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      _addPlane(arkitController, anchor);
    }
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor.identifier != anchorId || anchor is! ARKitPlaneAnchor) {
      return;
    }
    if (planeNode != null) {
      planeNode?.position = vector.Vector3(anchor.center.x, 0, anchor.center.z);
      plane?.width.value = anchor.extent.x;
      plane?.height.value = anchor.extent.z;
    }
  }

  void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
    anchorId = anchor.identifier;

    ARKitMaterial imageMaterial = ARKitMaterial(
      diffuse: ARKitMaterialProperty.image('assets/images/background.jpg'),
      transparency: 1.0,
    );

    plane = ARKitPlane(
      width: anchor.extent.x,
      height: anchor.extent.z,
      materials: [imageMaterial],
    );

    planeNode = ARKitNode(
      geometry: plane,
      position: vector.Vector3(anchor.center.x, 0, anchor.center.z),
      rotation: vector.Vector4(1, 0, 0, -math.pi / 2),
    );

    controller.add(planeNode!, parentNodeName: anchor.nodeName);
  }

  void _onScaleStart(ScaleStartDetails details) {
    initialFocalPoint = details.focalPoint;
    if (planeNode != null) {
      initialPlanePosition = planeNode!.position;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null && initialPlanePosition != null) {
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;

      planeNode!.position =
          initialPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }
}
