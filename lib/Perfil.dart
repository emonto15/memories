import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:memories/Constants.dart';

class Perfil extends StatefulWidget{
  @override
  _PerfilState createState() => new _PerfilState();
}

class _PerfilState extends State<Perfil>{

  var httpClient = new HttpClient();

 String nombre = "diego Perez";
  String edad = "21";
  String direccion = " calle 45 A sur # 39B 101";
  String paisNacimieno = "Colombia";
  String ciudadNacimiento="Envigado";
  String fechaNacimiento= "24-10-1996";
  String ocupacionPrincipal = "Estudiante";
  String pasaTiempo = "Deportes";
  String generoMusical = "Electronica";
  var nuevoMapa = new Map();

  void initState() {
    super.initState();
    _getUserInfo();
    }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DropdownButtonHideUnderline(
        child: new Container(
          padding: new EdgeInsets.all(35.0),
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Nombre:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(nombre,
                       style: new TextStyle(fontSize: 18.0),),
                    ),
                   
                  ],
                ),
              ),

              new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Edad:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(edad,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Dirección:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(direccion,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("País de Nacimiento:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(paisNacimieno,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Ciudad de Nacimiento:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(ciudadNacimiento,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Fecha de Nacimiento:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(fechaNacimiento,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Ocupación Principal:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(ocupacionPrincipal,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Pasa tiempo favorito:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(pasaTiempo,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

               new Container(
                padding: new EdgeInsets.only(top: 20.0),
                child: new Row(
                  children:[
                    new Container(
                      child: new Text("Género Musical favorito:",
                        style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,),
                    )),
                    new Container(
                      padding: new EdgeInsets.only(left: 20.0),
                      child: new Text(generoMusical,
                       style: new TextStyle(fontSize: 18.0),),
                    )
                  ],
                ),
              ),

              new Container(
                  padding: new EdgeInsets.all(20.0), child: new Center(
                child: new RaisedButton(
                  color: new Color(0xFF7E57C2),
                  child: new Text('Editar', style: new TextStyle(
                      color: Colors.white, fontSize: 18.0)),
                  onPressed: null,
                ),
              )
              )

            ],
          ),
        ),
      )
    );
  }


  Future<Null> _getUserInfo() async {
    try {
      var user = new Map();
      
      user["google_id"] = "10";

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

      
      setState(() {
              nombre = nuevoMapa['nombre'];
              edad = nuevoMapa['edad'];
              direccion = nuevoMapa['direccion'];
              paisNacimieno = nuevoMapa['pais_nacimiento'];
              ciudadNacimiento = nuevoMapa['ciudad_nacimiento'];
              ocupacionPrincipal = nuevoMapa['ocupacion_principal'];
              pasaTiempo = nuevoMapa['pasatiempo'];
              generoMusical = nuevoMapa['genero_musical'];
            }); 
     
    } catch (err) {
      print(err);
    }
  }


}

 

