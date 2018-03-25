import 'package:flutter/material.dart';
import './FirstPage.dart' as first;
import './SecondPage.dart' as second;
import './ThirdPage.dart' as third;
import './landing_page.dart' as landingActivities;
import 'dart:async';
import 'package:camera/camera.dart';
List<CameraDescription> cameras;
Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new MaterialApp(
      home: new MyTabs()
  ));
}

class MyTabs extends StatefulWidget {
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
              new second.Second(),
              new first.ExpansionPanelsDemo(),
              new landingActivities.LandingPage(cameras: cameras),
              new third.Third(),
              new second.Second()
            ]
        )
    );
  }

}