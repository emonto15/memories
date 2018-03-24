import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:memories/main.dart' as main;


class CameraExampleHome extends StatefulWidget {
  final List<CameraDescription> cameras;
  CameraExampleHome ({this.cameras});

  @override
  _CameraExampleHomeState createState() {
    return new _CameraExampleHomeState(cameras: cameras);
  }
}

class _CameraExampleHomeState extends State<CameraExampleHome> {
  final List<CameraDescription> cameras;
  _CameraExampleHomeState({this.cameras});
  CameraDescription cameraD;
  static const platform = const MethodChannel('samples.flutter.io/battery');
  bool opening = false;
  CameraController controller;
  String imagePath;
  int pictureCount = 0;

  Future<Null> _sendEmotion(String path) async {
    try {
      await platform.invokeMethod('sendEmotion',<String, dynamic>{"path":path});
    } on PlatformException catch (e) {
      print("Failed to send emotion: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    for (CameraDescription cameraDescription in this.cameras) {
      if(cameraDescription.lensDirection == CameraLensDirection.front){
        cameraD = cameraDescription;
      }
    }


    return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new RaisedButton(child: const Icon(Icons.camera),
              onPressed: capture),
          const Text('Bahamas')
        ]
    );

  }

  Future<Null> capture() async {
    final CameraController tempController = controller;
    controller = null;
    await tempController?.dispose();
    controller =
    new CameraController(cameraD, ResolutionPreset.high);
    await controller.initialize();
    setState(() {});
    if (controller.value.hasError) {
      debugPrint('Camera error ${controller.value.errorDescription}');
    }
    if (controller.value.isStarted) {
      final Directory tempDir = await getTemporaryDirectory();
      if (!mounted) {
        return;
      }
      final String tempPath = tempDir.path;
      final String path = '$tempPath/picture${pictureCount++}.jpg';
      await controller.capture(path);
      if (!mounted) {
        return;
      }
      setState(
            () {
          imagePath = path;
          _sendEmotion(path);
        },
      );
    }
  }
}



/*Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new MaterialApp(home: new CameraExampleHome()));
}*/
