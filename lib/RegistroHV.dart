import 'package:flutter/material.dart';
import './utils/personModel.dart';
import 'package:memories/main.dart';

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
String parentesco;
String nombreFamiliar ="";







final List<String> _parentesco = <String>['Padre','Madre','Hijo'];


class _RegistroHVState extends State<RegistroHV> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<personModel> person =[];
  List<Widget> labelList = [];

  void initState() {
    super.initState();
    _buildLabels(null);
  }
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
              new Container(
                padding: new EdgeInsets.only(top: 40.0),
                child: new Row(
                    children: [
                      new Expanded(
                          child:  new Container(
                              padding: new EdgeInsets.only(top: 20.0),
                              child: new Text("Nombre:",
                                style: new TextStyle(fontSize: 18.0),)
                          )),
                      new Expanded(
                          child:  new TextField(
                              controller: _controller,
                              onChanged: (String str) {
                                setState(() {
                                  nombreFamiliar = str;
                                });
                              }
                          )),
                      new Expanded(
                          child: new Text("Parentesco:",
                            style: new TextStyle(fontSize: 18.0),
                          )),
                      new Expanded(
                          child:  new InputDecorator(
                              decoration: const InputDecoration(
                                hintText: '',
                              ),
                              isEmpty: parentesco == null,
                              child: new DropdownButton<String>(
                                  value: parentesco,
                                  isDense: true,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      parentesco = newValue;
                                    });
                                  },
                                  items: _parentesco.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList()))),
                      new Expanded(
                          child: new IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.green,
                              onPressed: _addPerson
                          ))

                    ] ),
              ),
              new Container(
                padding: new EdgeInsets.only(bottom:100.0),
                child: new Column(
                    children: labelList
                ),
              ),
              new Container(
                  padding: new EdgeInsets.all(20.0), child: new Center(
                child: new RaisedButton(
                  color: new Color(0xFF7E57C2),
                  child: new Text('Enviar', style: new TextStyle(
                      color: Colors.white, fontSize: 18.0)),
                  onPressed: _handleSubmitted,
                ),
              )
              )

            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLabels(int editIndex) {
    labelList = [];


    for (int index = 0; index < person.length;index++){
      labelList.add(
          new Row(children: [
            new Expanded(
                child: new Text(person[index].nombre,
                  style: new TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.left,
                )
            ),
            new Expanded(
                child: new Text(person[index].parentesco,
                  style: new TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                )),
            new Expanded(
                child: new IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.green,
                    onPressed: () => _removePersonAt(index)
                )),

          ])
      );
    }


    return labelList;
  }

  _handleSubmitted(){
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => MyTabs()));
  }
  _addPerson(){
    setState(() {
      if(_controller.text.isNotEmpty && parentesco!=null) {
        person.add(new personModel(nombreFamiliar, parentesco));
        _buildLabels(null);
        _controller.clear();
      }else{
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              content: new Text('Nombre o parentesco vacio'),
            )
        );
      }

    });
  }

  _removePersonAt(int index) {
    setState((){
      if(person.length >= 1) {
        person.removeAt(index);
        _buildLabels(null);
      } else {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              content: new Text('No se pudo eliminar'),
            )
        );
      }
    });
  }

}