import 'package:flutter/material.dart';
import 'package:memories/E_Paciente.dart';
import './Perfil.dart' as perfil;
import './Examen.dart' as second;
import './Reportes.dart' as third;
import './Landing_page.dart' as landingActivities;
import 'dart:async';
import 'package:camera/camera.dart';


class MyTabsTwo extends StatefulWidget {
  @override
  MyTabsTwoState createState() => new MyTabsTwoState();
}

class MyTabsTwoState extends State<MyTabsTwo> with SingleTickerProviderStateMixin {


  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding:false,
        appBar: new AppBar(
            backgroundColor:  new Color(0xFF9575CD),
            flexibleSpace: new TabBar(
              controller: controller,
              tabs: <Tab>[
                new Tab(child: new Text("Paciente", style: new TextStyle(fontSize: 18.0))),
                new Tab(child: new Text("Informante", style: new TextStyle(fontSize: 18.0))),
              ]
            )
        ),

        body: new TabBarView(
            physics: new NeverScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              new ExamenPaciente(),
              new perfil.Perfil()
            ]
        )
    );
  }

}
