import 'package:flutter/material.dart';
import './Perfil.dart' as perfil;
import './Examen.dart' as examen;
import './Reportes.dart' as reportes;
import './Landing_page.dart' as landingActivities;
import 'dart:async';
import 'package:camera/camera.dart';
import 'login.dart';
List<CameraDescription> cameras;
Future<Null> main() async {
  cameras = await availableCameras();
  if(true == true){
    runApp(new MaterialApp(
        home: new LoginPage()
    ));
  }else {
    runApp(new MaterialApp(
        home: new MyTabs()
    ));
  }
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
              new perfil.Perfil(),
              new examen.MyTabsTwo(),
              new landingActivities.LandingPage(cameras: cameras),
              new reportes.Report(),
              new reportes.Report()
            ]
        )
    );
  }

}