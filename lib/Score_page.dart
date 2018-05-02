import 'package:flutter/material.dart';

import './Activities_Landing_page.dart';
import './main.dart' as main;

class ScorePage extends StatelessWidget {

  final int score;
  final int totalQuestions;
  final String googleId;

  ScorePage(this.score, this.totalQuestions,this.googleId);

  @override
  Widget build(BuildContext context) {
    return new Material(
        color: new Color(0xFF9575CD),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Tu puntaje: ", style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.0),),
            new Text(score.toString() + "/" + totalQuestions.toString(), style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50.0)),
            new IconButton(
                icon: new Icon(Icons.arrow_right),
                color: Colors.white,
                iconSize: 50.0,
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new main.MyTabs(googleId)), (Route route) => route == null)
            )
          ],
        )
    );
  }
}