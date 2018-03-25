import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import './Activities.dart';

class LandingPage extends StatelessWidget {
  final List<CameraDescription> cameras;
  LandingPage({this.cameras});
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new QuizPage(cameras: cameras))),
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
}