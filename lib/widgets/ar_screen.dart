import 'package:archive/api/models/post.dart';
import 'package:archive/api/services/post.dart';
import 'package:archive/common/geo.dart';
import 'package:archive/widgets/brand_button.dart';
import 'package:archive/widgets/enter_quote.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heroicons/heroicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  PostService postService = PostService();

  late ARKitController arkitController;

  ARKitPlane? plane;
  ARKitNode? planeNode;
  String? anchorId;

  Offset? initialFocalPoint;
  vector.Vector3? initialPlanePosition;
  vector.Vector3? currentPlanePosition;

  bool planePlaced = false;
  DateTime? lastUpdateTime;

  vector.Vector3 _position = vector.Vector3(0, 0, 0);
  vector.Vector4 _rotation = vector.Vector4(0, 0, 0, 0);
  bool _isEditing = false;
  bool _isSavingPost = false;
  String _quote = "";

  @override
  void initState() {
    super.initState();

    determinePosition().then((geoPos) {
      debugPrint("Current Position: ${geoPos.latitude}, ${geoPos.longitude}");
      postService.getPostsNearby(geoPos).then((QuerySnapshot<IPost> snapshot) {
        debugPrint("Posts found: ${snapshot.docs.length}");
        snapshot.docs.forEach((doc) {
          final data = doc.data();
          final quote = data.quote;
          final position = data.position;
          final rotation = data.rotation;

          final positionVector = vector.Vector3(
            position.x,
            position.y,
            position.z,
          );

          final rotationVector = vector.Vector4(
            rotation.x,
            rotation.y,
            rotation.z,
            rotation.w,
          );

          _addPlaneAtPosition(positionVector, rotationVector, quote);
        });
      });
    });
  }

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
            child: Stack(children: [
          GestureDetector(
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
              environmentTexturing:
                  ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
            ),
          ),
          if (_isEditing)
            Positioned(
                left: 15,
                top: 10,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: BrandButton(
                          label: "Clear",
                          icon: HeroIcon(HeroIcons.trash,
                              color: Colors.white.withOpacity(0.5)),
                          onTap: () {},
                          type: BrandButtonType.matte,
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: BrandButton(
                            label: "ARchive",
                            loading: _isSavingPost,
                            disabled: _quote.isEmpty,
                            icon: HeroIcon(HeroIcons.arrowRightStartOnRectangle,
                                color: Colors.white.withOpacity(0.5)),
                            onTap: () async {
                              setState(() {
                                _isSavingPost = true;
                              });

                              await determinePosition().then((geoPos) async {
                                debugPrint(
                                    "Position: ${geoPos.latitude}, ${geoPos.longitude}");
                                await postService.addPost(
                                    _quote, _position, _rotation, geoPos);
                              });

                              setState(() {
                                _isSavingPost = false;
                                _quote = "";
                                _isEditing = !_isEditing;
                              });
                            },
                            type: BrandButtonType.matte,
                          ),
                        )
                      ],
                    ))),
          Positioned(
            left: 15,
            bottom: 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: BrandButton(
                disabled: _isEditing,
                label: _isEditing ? "Tap add to add note!" : "ARchive Note",
                icon: HeroIcon(HeroIcons.pencil, color: Colors.white, size: 16),
                onTap: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                type: BrandButtonType.accent,
              ),
            ),
          ),
        ])));
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (nodes) => onNodeTapHandler(nodes);
  }

  void onNodeTapHandler(List<ARKitTestResult> nodesList) {
    if (nodesList.isNotEmpty) {
      final tappedNode = nodesList.first;

      //final quote = "Hello World!";

      showCupertinoModalBottomSheet(
        context: context,
        shape: Border.all(
            width: 1.0, color: const Color.fromARGB(255, 23, 23, 23)),
        topRadius: Radius.circular(10),
        backgroundColor: const Color.fromARGB(255, 10, 10, 10),
        builder: (context) => SizedBox(
            height: 300,
            child: EnterQuote(
              onSubmit: (quote) {
                Navigator.of(context).pop();

                final transform = tappedNode.worldTransform;

                final position = vector.Vector3(
                  transform.getTranslation().x,
                  transform.getTranslation().y,
                  transform.getTranslation().z,
                );

                final rotation = vector.Vector4(0, 1, 0, math.pi / 2);

                setState(() {
                  _position = position;
                  _rotation = rotation;
                  _quote = quote;
                });

                _addPlaneAtPosition(position, rotation, quote);
              },
            )),
      );
    }
  }

  void _addPlaneAtPosition(
      vector.Vector3 position, vector.Vector4 rotation, String quote) async {
    final normal = vector.Vector3(0, 1, 0);
    position.add(normal.normalized() * 0.1);

    String canvasImage = await getCanvasImageBase64(quote);

    ARKitMaterial imageMaterial = ARKitMaterial(
      // diffuse: ARKitMaterialProperty.image('assets/images/background.jpg'),
      diffuse:
          ARKitMaterialProperty.image('data:image/png;base64,$canvasImage'),
      transparency: 1.0,
    );

    plane = ARKitPlane(
      width: 1.0,
      height: 1.0,
      materials: [imageMaterial],
    );

    planeNode = ARKitNode(
      geometry: plane,
      position: position,
      rotation: rotation,
    );

    arkitController.add(planeNode!);
    debugPrint("Plane added at wall location with ID: ${planeNode!.name}");
    debugPrint("Adding plane at: $position");
    debugPrint(
        "Plane size: width=${plane!.width.value}, height=${plane!.height.value}");
    debugPrint("$rotation");
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null && initialPlanePosition != null) {
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;
      planeNode!.position =
          initialPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }

  void _onPanUpdate(ScaleUpdateDetails details) {
    if (initialFocalPoint != null &&
        currentPlanePosition != null &&
        planeNode != null) {
      // Calculate the movement based on the focal point
      double dx = details.focalPoint.dx - initialFocalPoint!.dx;
      double dy = details.focalPoint.dy - initialFocalPoint!.dy;

      // Update the position of the planeNode
      planeNode!.position =
          currentPlanePosition! + vector.Vector3(dx * 0.01, 0, dy * 0.01);
    }
  }

  Future<String> getCanvasImageBase64(String str) async {
    var builder =
        ui.ParagraphBuilder(ui.ParagraphStyle(fontStyle: FontStyle.normal));

    builder.pushStyle(ui.TextStyle(
      fontSize: 24,
      fontWeight: ui.FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ));
    builder.addText(str);
    ui.Paragraph paragraph = builder.build();

    const double imageWidth = 100;
    const double imageHeight = 100;
    paragraph.layout(const ui.ParagraphConstraints(width: imageWidth));

    final recorder = ui.PictureRecorder();
    var newCanvas = Canvas(recorder);

    newCanvas.drawParagraph(paragraph, Offset(0, 0));

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
