import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:convert';


class ARWidget extends StatefulWidget {
  const ARWidget({Key? key}) : super(key: key);

  @override
  State<ARWidget> createState() => _ARWidgetState();
}

class _ARWidgetState extends State<ARWidget> {
  late ARKitController arkitController;
  ARKitPlane? plane;
  ARKitNode? planeNode;
  String? anchorId;

  Offset? initialFocalPoint;
  vector.Vector3? initialPlanePosition;
  vector.Vector3? currentPlanePosition;

  bool planePlaced = false;
  DateTime? lastUpdateTime;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15), 
      child: CupertinoPageScaffold(
        child: GestureDetector(
          onScaleStart: (details) {
            initialFocalPoint = details.focalPoint;
            if (planeNode != null) {
              currentPlanePosition = planeNode!.position;
            }
          },
          onScaleUpdate: (details) {
            if (details.scale != 1.0) {
              _onScaleUpdate(details);
            } else {
              _onPanUpdate(details);
            }
          },
          child: ARKitSceneView(
            showFeaturePoints: false,
            enableTapRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
            planeDetection: ARPlaneDetection.vertical,
            environmentTexturing: ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
          ),
        ),
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

      final quote = "Hello World!";

      _addPlaneAtPosition(tappedNode.worldTransform, quote);

    }
  }

  void _addPlaneAtPosition(Matrix4 transform, String quote) async {
    final position = vector.Vector3(
      transform.getTranslation().x,
      transform.getTranslation().y,
      transform.getTranslation().z,
    );

    final normal = vector.Vector3(0, 1, 0);
    position.add(normal.normalized() * 0.1);

    String canvasImage = await getCanvasImageBase64(quote);

    ARKitMaterial imageMaterial = ARKitMaterial(
      // diffuse: ARKitMaterialProperty.image('assets/images/background.jpg'),
      diffuse: ARKitMaterialProperty.image('data:image/png;base64,$canvasImage'),
      transparency: 1.0,
    );

    plane = ARKitPlane(
      width: 1.0,
      height: 1.0,
      materials: [imageMaterial],
    );

    final rotation = vector.Vector4(1, 1, 1, 1);

    planeNode = ARKitNode(
      geometry: plane,
      position: position,
      rotation: rotation,
    );

    arkitController.add(planeNode!);
    debugPrint("Plane added at wall location with ID: ${planeNode!.name}");
    debugPrint("Adding plane at: $position");
    debugPrint("Plane size: width=${plane!.width.value}, height=${plane!.height.value}");
    debugPrint("$rotation");
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null && initialPlanePosition != null) {
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;
      planeNode!.position = initialPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }

  void _onPanUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null && currentPlanePosition != null && planeNode != null) {
      // Calculate the movement based on the focal point
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;

      // Update the position of the planeNode
      planeNode!.position = currentPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }

  Future<String> getCanvasImageBase64(String str) async {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(fontStyle: FontStyle.normal));
    builder.addText(str);
    ui.Paragraph paragraph = builder.build();

    const double imageWidth = 100;
    const double imageHeight = 100;
    paragraph.layout(const ui.ParagraphConstraints(width: imageWidth));

    final recorder = ui.PictureRecorder();
    var newCanvas = Canvas(recorder);

    newCanvas.drawParagraph(paragraph, Offset(0,0));

    final picture = recorder.endRecording();
    var res = await picture.toImage(imageWidth.toInt(), imageHeight.toInt());
    ByteData? data = await res.toByteData(format: ui.ImageByteFormat.png);

    if (data != null) {
        final buffer = data.buffer.asUint8List();        
        String base64String = base64Encode(buffer);
        return base64String;
    } else {
        throw Exception("Failed to convert image to byte data");
    }
  }
}
