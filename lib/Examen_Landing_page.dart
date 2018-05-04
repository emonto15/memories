import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:memories/E_Paciente.dart' as paciente;

class LandingPage extends StatelessWidget {
  final String googleId;
  LandingPage(this.googleId);
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new paciente.ExamenPaciente(this.googleId))),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Comenzar examen", style: new TextStyle(color: new Color(0xFF9575CD), fontSize: 38.0, fontWeight: FontWeight.bold),),
            new Text("¡Recuerda que debe estar tanto el paciente como el acompañante!", style: new TextStyle(color: new Color(0xFF9575CD), fontSize: 20.0, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}