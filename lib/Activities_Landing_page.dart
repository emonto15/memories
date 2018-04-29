import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './Activities.dart';

class LandingPage extends StatelessWidget {
  List<CameraDescription> cameras;
  final String googleId;
  LandingPage(this.googleId);
  
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new InkWell(
        onTap: () => _handleTap(context),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Comenzar Actividades", style: new TextStyle(color: new Color(0xFF9575CD), fontSize: 38.0, fontWeight: FontWeight.bold),),
            new Text("¡Toca para comenzar!", style: new TextStyle(color: new Color(0xFF9575CD), fontSize: 20.0, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
  
  Future<Null> _handleTap(context) async {
     cameras = await availableCameras();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuizPage(cameras: cameras,googleId:googleId)));
  }
}