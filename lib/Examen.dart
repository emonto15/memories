import 'package:flutter/material.dart';
import 'package:memories/E_Paciente.dart';
import 'package:memories/E_Informante.dart';

class MyTabsTwo extends StatefulWidget {
  @override
  MyTabsTwoState createState() => new MyTabsTwoState();
}

class MyTabsTwoState extends State<MyTabsTwo>
    with SingleTickerProviderStateMixin {


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
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
            backgroundColor: new Color(0xFF9575CD),
            flexibleSpace: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(child: new Text(
                      "Paciente", style: new TextStyle(fontSize: 18.0))),
                  new Tab(child: new Text(
                      "Informante", style: new TextStyle(fontSize: 18.0))),
                ]
            )
        ),

        body: new TabBarView(
            physics: new AlwaysScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              new ExamenPaciente(),
              new ExamenInformante()
            ]
        )
    );
  }

}
