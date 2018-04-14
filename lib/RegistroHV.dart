import 'package:flutter/material.dart';

class RegistroHV extends StatefulWidget {
  @override
  _RegistroHVState createState() => new _RegistroHVState();
}

final List<String> _genero = <String>['Masculino', 'Femenino'];
final List<String> _escolaridad = <String>['Primaria', 'Bachillerato','Pre-grado', 'Especialización','Maestría', "Doctorado"];
final List<String> _estadoCivil = <String>['Soltero', 'Casado','Divorciado', 'Viudo'];
final List<String> _pasatiempo = <String>['Deportes', 'Dibujar','Bailar', 'Pintar','leer','Escuchar Musica','Ver televisión'];
final List<String> _generoMusical = <String>['Música clásica', 'Blues','Jazz', 'Rock and Roll','Soul','Rock','Pop','Electronica','Salsa'];

String nombre = "";
String edad = "";
String genero;
String direccion="";
String paisNacimiento = "";
String ciudadNacimiento = "";
String ocupacion = "";
String escolaridad;
String colegio = "";
String estadoCivil;
String pasatiempo;
String generoMusical;
String lugarResidencia="";

class _RegistroHVState extends State<RegistroHV> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Center(child: new Text("Datos personales")),
        backgroundColor: new Color(0xFF7E57C2),
          automaticallyImplyLeading: false),
      body: new DropdownButtonHideUnderline(
        child: new Container(
          padding: new EdgeInsets.all(35.0),
          child: new ListView(
            children: <Widget>[
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                child: new Text("1. Nombre del paciente:",
                style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                decoration: new InputDecoration(
                  hintText: "Escribe el nombre del paciente"
                ),
                onChanged: (String str){
                  setState(() {
                    nombre =  str;
                  });
                }
              ),
              new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Text("2. Edad del paciente:",
                style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                decoration: new InputDecoration(
                    hintText:"Escribe la edad del paciente"
                ),
               onChanged: (String str) {
                 setState(() {
                   edad = str;
                 });
               }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "3. Género",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: genero == null,
                  child: new DropdownButton<String>(
                      value: genero,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          genero = newValue;
                        });
                      },
                      items: _genero.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("4. Dirección:",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe la dirección del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      direccion = str;
                    });
                  }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("5. Pais de nacimiento:",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe el pais de nacimiento del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      paisNacimiento = str;
                    });
                  }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("6. Ciudad de nacimiento:",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe la ciudad de nacimiento del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      ciudadNacimiento = str;
                    });
                  }
              ),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("7. Lugar de residencia:",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe el lugar de residencia del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      lugarResidencia = str;
                    });
                  }
              ),


              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("8. Fecha de nacimiento:",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe la fecha de nacimiento del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      paisNacimiento = str;
                    });
                  }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("9. Ocupación principal :",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe la ocupación principal del paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      ocupacion = str;
                    });
                  }
              ),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "10. Escolaridad",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: escolaridad == null,
                  child: new DropdownButton<String>(
                      value: escolaridad,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          escolaridad = newValue;
                        });
                      },
                      items: _escolaridad.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("11. Colegio :",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escribe el colegio en el que estudio el paciente"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      colegio = str;
                    });
                  }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "12. Estado civil",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: estadoCivil == null,
                  child: new DropdownButton<String>(
                      value: estadoCivil,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          estadoCivil = newValue;
                        });
                      },
                      items: _estadoCivil.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("13. Fecha de Matrimonio :",
                    style: new TextStyle(fontSize: 18.0),)
              ),
              new TextField(
                  decoration: new InputDecoration(
                      hintText:"Escriba la fecha de matrimonio del paciente: DD/MM/AAAA"
                  ),
                  onChanged: (String str) {
                    setState(() {
                      colegio = str;
                    });
                  }
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "14. Pasatiempo",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: pasatiempo == null,
                  child: new DropdownButton<String>(
                      value: pasatiempo,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          pasatiempo = newValue;
                        });
                      },
                      items: _pasatiempo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "15. Género musical",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: generoMusical == null,
                  child: new DropdownButton<String>(
                      value: generoMusical,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          generoMusical = newValue;
                        });
                      },
                      items: _generoMusical.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
            ],
          ),
        ),
      ),
    );
  }

}