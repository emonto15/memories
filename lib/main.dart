import 'package:flutter/material.dart';
import 'package:memories/Perfil.dart' as perfil;
import 'package:memories/Examen_Landing_page.dart' as examen;
import 'package:memories/Reportes.dart' as reportes;
import 'package:memories/Activities_Landing_page.dart' as landingActivities;
import 'dart:async';
import 'package:memories/login.dart';
import 'package:memories/tts.dart';
import 'package:memories/Perfil.dart';
import 'package:memories/RegistroHV.dart';

Future<Null> main() async {
  if(true == true){
    String googleId = "1";
    runApp(new MaterialApp(
      
        home: new MyTabs(googleId)
    ));
  }
}

class MyTabs extends StatefulWidget {

  MyTabs(this.googleId);
  final String googleId;

  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MyTabs> with SingleTickerProviderStateMixin {


  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NeverScrollableScrollPhysics neverScrollableScrollPhysics = new NeverScrollableScrollPhysics();
    return new Scaffold(
        resizeToAvoidBottomPadding:false,
        appBar: new AppBar(
            title: new Center(child: new Text("Memories")),
            backgroundColor: new Color(0xFF7E57C2),
            bottom: new TabBar(
              indicatorColor: Colors.white,
              controller: controller,
              tabs: <Tab>[
                new Tab(child: new Text("Perfil", style: new TextStyle(fontSize: 18.0))),
                new Tab(child: new Text("Examen", style: new TextStyle(fontSize: 18.0))),
                new Tab(child: new Text("Actividades", style: new TextStyle(fontSize: 18.0))),
                new Tab(child: new Text("Musicoterapia", style: new TextStyle(fontSize: 18.0))),
                new Tab(child: new Text("Reportes", style: new TextStyle(fontSize: 18.0)))
              ],
            )
        ),

        body: new TabBarView(
            physics: neverScrollableScrollPhysics,
            controller: controller,
            children: <Widget>[
              new perfil.Perfil(widget.googleId),
              new examen.LandingPage(),
              new landingActivities.LandingPage(widget.googleId),
              new reportes.Report(),
              new reportes.Report()
            ]
        )
    );
  }

}