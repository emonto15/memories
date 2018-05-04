import 'package:flutter/material.dart';
import './utils/personModel.dart';
import 'package:memories/main.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:memories/Constants.dart';

class EditarPerfil extends StatefulWidget {

   EditarPerfil(this.googleId);
  final String googleId;

  @override
  _EditarPerfilState createState() => new _EditarPerfilState();

}

final List<String> _genero = <String>['Masculino', 'Femenino'];
final List<String> _escolaridad = <String>['Primaria', 'Bachillerato','Pre-grado', 'Especialización','Maestría', "Doctorado"];
final List<String> _estadoCivil = <String>['Soltero', 'Casado','Divorciado', 'Viudo'];
final List<String> _pasatiempo = <String>['Deportes', 'Dibujar','Bailar', 'Pintar','leer','Escuchar Musica','Ver televisión'];
final List<String> _generoMusical = <String>['Música clásica', 'Blues','Jazz', 'Rock and Roll','Soul','Rock','Pop','Electronica','Salsa'];
final List<String> _capacidadFisica = <String>['Excelente', 'Mas o menos', 'Mala'];
final List<String> _capacidadCaminar = <String>['Con normalidad', 'Con dificultad', 'No es capaz'];
final List<String> _parentesco = <String>['Padre','Madre','Hijo'];


String nombre = "";
String edad = "";
String genero;
String direccion="";
String paisNacimiento = "";
String ciudadNacimiento = "";
String ocupacion = "";
String escolaridad = "";
String colegio = "";
String estadoCivil;
String pasatiempo;
String generoMusical;
String lugarResidencia="";
String parentesco = "";
String nombreFamiliar ="";
String capacidadFisica = "";
String capacidadCaminar = "";
String fechaNacimiento = "";
String fechaMatrimonio = "";
var nuevoMapa = new Map();









class _EditarPerfilState extends State<EditarPerfil> {
  var httpClient = new HttpClient();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  TextEditingController _controllerNombre;
  TextEditingController _controllerEdad;
  TextEditingController _controllerDireccion;
  TextEditingController _controllerPaisNacimiento;
  TextEditingController _controllerCiudadNacimiento;
  TextEditingController _controllerLugarResidencia;
  TextEditingController _controllerFechaNacimiento;
  TextEditingController _controllerOcupacion;
  TextEditingController _controllerColegio;
  TextEditingController _controllerFechaMatrimonio;
  




  List<personModel> person =[];
  List<Widget> labelList = [];

  void initState() {
    super.initState();
   // _getUserInfo();
    
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                },
                controller:_controllerNombre

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
               },
               controller: _controllerEdad,
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
                  },
                  controller: _controllerDireccion,
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
                  },
                  controller: _controllerPaisNacimiento,
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
                  },
                  controller: _controllerCiudadNacimiento,
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
                  },
                  controller: _controllerLugarResidencia,
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
                      fechaNacimiento = str;
                    });
                  },
                  controller: _controllerFechaNacimiento,
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
                  },
                  controller: _controllerOcupacion,
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
                  },
                  controller: _controllerColegio,
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
                      fechaMatrimonio = str;
                    });
                  },
                  controller: _controllerFechaMatrimonio,
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
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "16. Capacidad Fisica",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: capacidadFisica == null,
                  child: new DropdownButton<String>(
                      value: capacidadFisica,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          capacidadFisica = newValue;
                        });
                      },
                      items: _capacidadFisica.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                      "17. Capacidad para caminar",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: capacidadCaminar == null,
                  child: new DropdownButton<String>(
                      value: capacidadCaminar,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          capacidadCaminar = newValue;
                        });
                      },
                      items: _capacidadCaminar.map((String value) {
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
                  onPressed: _updateUser,
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

   Future<Null> _updateUser() async {
    try {
      var user = new Map();
      
      user["nombre"] =nombre;
      user["edad"] =edad;
      user["genero"] =genero;
      user["google_id"] =widget.googleId;
      user["registrado"] =true;
      user["direccion"] =direccion;
      user["pais_nacimiento"] =paisNacimiento;
      user["ciudad_nacimiento"] =ciudadNacimiento;
      user["lugar_residencia"] =lugarResidencia;
      user["fecha_nacimiento"] = fechaNacimiento;
      user["ocupacion_principal"] =ocupacion;
      user["escolaridad"] =escolaridad;
      user["colegio"] =colegio;
      user["estado_civil"] =estadoCivil;
      user["fecha_matrimonio"] =fechaMatrimonio;
      user["pasatiempo"] =pasatiempo;
      user["genero_musical"] =generoMusical;
      user["capacidad_fisica"] =capacidadFisica;
      user["capacidad_caminar"] =capacidadCaminar;

      List<Map> familiares = [];
      
      for (int i = 0; i< person.length;i++){
       
          familiares.add({
            "nombre":person[i].nombre,
            "parentesco": person[i].parentesco
          });
      }
      user["familiares"] = familiares;
      print(user);
      
      final String requestBody = json.encode(user);
      print(requestBody);
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(URL + '/users/updateUser'))
            ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
            ..headers.contentType = ContentType.JSON
            ..headers.contentLength = requestBody.length
            ..headers.chunkedTransferEncoding = false;
      request.write(requestBody);
      HttpClientResponse response = await request.close();
      print(json
          .decode(await response.transform(utf8.decoder).join())['nombre']);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new MyTabs(widget.googleId)));
    } catch (err) {
      print(err);
    }
  }


   Future<Null> _getUserInfo() async {
    try {
      var user = new Map();
      
      user["google_id"] = widget.googleId;

      final String requestBody = json.encode(user);
      print(requestBody);
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse(URL + '/users/getUserInfo'))
            ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
            ..headers.contentType = ContentType.JSON
            ..headers.contentLength = requestBody.length
            ..headers.chunkedTransferEncoding = false;
       request.write(requestBody);
      HttpClientResponse response = await request.close();
      nuevoMapa = json
          .decode(await response.transform(utf8.decoder).join());
        print("este es el mapa");
        print(nuevoMapa);
      
      setState(() {

              nombre = nuevoMapa['nombre'];
              edad = nuevoMapa['edad'];
              genero = nuevoMapa['genero'];
              direccion = nuevoMapa['direccion'];
              fechaNacimiento = nuevoMapa['fecha_nacimiento'];
              paisNacimiento = nuevoMapa['pais_nacimiento'];
              ciudadNacimiento = nuevoMapa['ciudad_nacimiento'];
              ocupacion = nuevoMapa['ocupacion_principal'];
              escolaridad = nuevoMapa['escolaridad'];
              colegio = nuevoMapa['colegio'];
              estadoCivil = nuevoMapa['estado_civil'];
              pasatiempo = nuevoMapa['pasatiempo'];
              generoMusical = nuevoMapa['genero_musical'];
              lugarResidencia = nuevoMapa['lugar_residencia'];
              capacidadFisica = nuevoMapa['capacidad_fisica'];
              capacidadCaminar = nuevoMapa['capacidad_caminar'];
              fechaMatrimonio = nuevoMapa['fecha_matrimonio'];

              _controllerNombre = new TextEditingController(text : nombre);
              _controllerEdad = new TextEditingController(text : edad);
              _controllerDireccion = new TextEditingController(text : direccion);
              _controllerPaisNacimiento = new TextEditingController(text : paisNacimiento);
              _controllerCiudadNacimiento = new TextEditingController(text : ciudadNacimiento);
              _controllerLugarResidencia = new TextEditingController(text : lugarResidencia);
              _controllerFechaNacimiento = new TextEditingController(text : fechaNacimiento);
              _controllerOcupacion = new TextEditingController(text : ocupacion);
              _controllerColegio = new TextEditingController(text : colegio);
              _controllerFechaMatrimonio = new TextEditingController(text : fechaMatrimonio);


            // if ( nuevoMapa['familiares'] != null){

                  for(int i = 0; i <nuevoMapa['familiares'].length;i++ ){
                person.add(new personModel(nuevoMapa["familiares"][i]['nombre'], nuevoMapa["familiares"][i]['parentesco']));
              }
              print(nuevoMapa['familiares'].length);
              print(nuevoMapa["familiares"][0]['nombre']);

             // }
              
             
              
  


              

              _buildLabels(null);


            }); 
     
    } catch (err) {
      print(err);
    }
  }

}