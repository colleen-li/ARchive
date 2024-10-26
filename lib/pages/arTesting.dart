import 'package:flutter/cupertino.dart';

class ArTesting extends StatefulWidget {
  const ArTesting({super.key});

  @override
  State<ArTesting> createState() => _ArTesting();
}

class _ArTesting extends State<ArTesting> {

  late ARKitController arkitController;
  // ARKitPlane? plane;
  // ARKitNode? node;
  // String? anchorId;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Hello World Hackathon'),
      ),
      body: Container(
        child: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          environmentTexturing:
              ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
        ),
      ));

  
    void onARKitViewCreated(ARKitController arkitController) {
      this.arkitController = arkitController;
      this.arkitController.add(_createText());
    }

    ARKitNode _createText() {
      final text = ARKitText(
        text: 'Hello World!',
        extrusionDepth: 1,
        materials: [
          ARKitMaterial(
            diffuse: ARKitMaterialProperty.color(Colors.blue),
          )
        ],
      );
      return ARKitNode(
        geometry: text,
        position: vector.Vector3(-0.3, 0.3, -1.4),
        scale: vector.Vector3(0.02, 0.02, 0.02),
      );
    }
}