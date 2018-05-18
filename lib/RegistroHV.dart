import 'package:flutter/material.dart';
import './utils/personModel.dart';
import 'package:memories/main.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:memories/Constants.dart';
import 'package:intl/intl.dart';

class RegistroHV extends StatefulWidget {
  RegistroHV(this.googleId);

  final String googleId;

  @override
  _RegistroHVState createState() => new _RegistroHVState();
}

final List<String> _genero = <String>['Masculino', 'Femenino'];
final List<String> _escolaridad = <String>[
  'Primaria',
  'Bachillerato',
  'Pre-grado',
  'Especialización',
  'Maestría',
  "Doctorado"
];
final List<String> _estadoCivil = <String>[
  'Soltero',
  'Casado',
  'Divorciado',
  'Viudo'
];
final List<String> _pasatiempo = <String>[
  'Deportes',
  'Dibujar',
  'Bailar',
  'Pintar',
  'leer',
  'Escuchar Musica',
  'Ver televisión'
];
final List<String> _generoMusical = <String>[
  'Música clásica',
  'Blues',
  'Jazz',
  'Rock and Roll',
  'Soul',
  'Rock',
  'Pop',
  'Electronica',
  'Salsa'
];
final List<String> _capacidadFisica = <String>[
  'Excelente',
  'Mas o menos',
  'Mala'
];
final List<String> _capacidadCaminar = <String>[
  'Con normalidad',
  'Con dificultad',
  'No es capaz'
];

String nombre = "";
String edad = "";
String genero;
String direccion = "";
String departamentoNacimiento;
String depto = "Antioquia";
String ciudadNacimiento;
String ocupacion = "";
String escolaridad;
String colegio = "";
String estadoCivil;
String pasatiempo;
String generoMusical;
String lugarResidencia = "";
String parentesco;
String nombreFamiliar = "";
String capacidadFisica;
String capacidadCaminar;
DateTime fechaNacimiento = new DateTime.now();
DateTime fechaMatrimonio = new DateTime.now();

final List<String> _parentesco = <String>['Padre', 'Madre', 'Hijo'];

class _RegistroHVState extends State<RegistroHV> {
  var httpClient = new HttpClient();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  TimeOfDay birth_fromTime = const TimeOfDay(hour: 7, minute: 28);

  TextEditingController _controllerNombre = new TextEditingController();
  TextEditingController _controllerEdad = new TextEditingController();
  TextEditingController _controllerDireccion = new TextEditingController();
  TextEditingController _controllerLugarResidencia =
      new TextEditingController();
  TextEditingController _controllerOcupacion = new TextEditingController();
  TextEditingController _controllerColegio = new TextEditingController();
  List<personModel> person = [];
  List<Widget> labelList = [];

  void initState() {
    super.initState();
    _buildLabels(null);
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
                  child: new Text(
                    "1. Nombre del paciente:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerNombre,
                  decoration: new InputDecoration(
                      hintText: "Escribe el nombre del paciente"),
                  onChanged: (String str) {
                    setState(() {
                      nombre = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "2. Edad del paciente:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerEdad,
                  decoration: new InputDecoration(
                      hintText: "Escribe la edad del paciente"),
                  onChanged: (String str) {
                    setState(() {
                      edad = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("3. Género",
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
                  child: new Text(
                    "4. Dirección:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerDireccion,
                  decoration: new InputDecoration(
                      hintText: "Escribe la dirección del paciente"),
                  onChanged: (String str) {
                    setState(() {
                      direccion = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "5. Departamento de nacimiento:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: departamentoNacimiento == null,
                  child: new DropdownButton<String>(
                      value: departamentoNacimiento,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          departamentoNacimiento = newValue;
                          depto = newValue;
                        });
                      },
                      items: DEPTOS_CIUDADES.keys.toList().map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "6. Ciudad de nacimiento:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: departamentoNacimiento == null,
                      child: new DropdownButton<String>(
                          value: ciudadNacimiento,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              ciudadNacimiento = newValue;
                            });
                          },
                          items: DEPTOS_CIUDADES[depto]
                              .map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "7. Lugar de residencia:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerLugarResidencia,
                  decoration: new InputDecoration(
                      hintText: "Escribe el lugar de residencia del paciente"),
                  onChanged: (String str) {
                    setState(() {
                      lugarResidencia = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "8. Fecha de nacimiento",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new _DateTimePicker(
                labelText: 'Fecha',
                selectedDate: fechaNacimiento,
                selectedTime: birth_fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    fechaNacimiento = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    birth_fromTime = time;
                  });
                },
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "9. Ocupación principal :",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerOcupacion,
                  decoration: new InputDecoration(
                      hintText: "Escribe la ocupación principal del paciente"),
                  onChanged: (String str) {
                    setState(() {
                      ocupacion = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("10. Escolaridad",
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
                  child: new Text(
                    "11. Colegio :",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new TextField(
                  controller: _controllerColegio,
                  decoration: new InputDecoration(
                      hintText:
                          "Escribe el colegio en el que estudio el paciente"),
                  onChanged: (String str) {
                    setState(() {
                      colegio = str;
                    });
                  }),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("12. Estado civil",
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
                  child: new Text(
                    "13. Fecha de matrimonio",
                    style: new TextStyle(fontSize: 18.0),
                  )),
              new _DateTimePicker(
                labelText: 'Fecha',
                selectedDate: fechaMatrimonio,
                selectedTime: birth_fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    fechaMatrimonio = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    birth_fromTime = time;
                  });
                },
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 20.0),
                  child: new Text("14. Pasatiempo",
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
                  child: new Text("15. Género musical",
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
                  child: new Text("16. Capacidad Fisica",
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
                  child: new Text("17. Capacidad para caminar",
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
                child: new Row(children: [
                  new Expanded(
                      child: new Container(
                          padding: new EdgeInsets.only(top: 20.0),
                          child: new Text(
                            "Nombre:",
                            style: new TextStyle(fontSize: 18.0),
                          ))),
                  new Expanded(
                      child: new TextField(
                          controller: _controller,
                          onChanged: (String str) {
                            setState(() {
                              nombreFamiliar = str;
                            });
                          })),
                  new Expanded(
                      child: new Text(
                    "Parentesco:",
                    style: new TextStyle(fontSize: 18.0),
                  )),
                  new Expanded(
                      child: new InputDecorator(
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
                          onPressed: _addPerson))
                ]),
              ),
              new Container(
                padding: new EdgeInsets.only(bottom: 100.0),
                child: new Column(children: labelList),
              ),
              new Container(
                  padding: new EdgeInsets.all(20.0), child: new Center(
                child: new RaisedButton(
                  color: new Color(0xFF7E57C2),
                  child: new Text('Enviar', style: new TextStyle(
                      color: Colors.white, fontSize: 18.0)),
                  onPressed: createUser,
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

    for (int index = 0; index < person.length; index++) {
      labelList.add(new Row(children: [
        new Expanded(
            child: new Text(
          person[index].nombre,
          style: new TextStyle(fontSize: 18.0),
          textAlign: TextAlign.left,
        )),
        new Expanded(
            child: new Text(
          person[index].parentesco,
          style: new TextStyle(fontSize: 18.0),
          textAlign: TextAlign.center,
        )),
        new Expanded(
            child: new IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.green,
                onPressed: () => _removePersonAt(index))),
      ]));
    }

    return labelList;
  }

  _addPerson() {
    setState(() {
      if (_controller.text.isNotEmpty && parentesco != null) {
        person.add(new personModel(nombreFamiliar, parentesco));
        _buildLabels(null);
        _controller.clear();
      } else {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text('Nombre o parentesco vacio'),
        ));
      }
    });
  }

  _removePersonAt(int index) {
    setState(() {
      if (person.length >= 1) {
        person.removeAt(index);
        _buildLabels(null);
      } else {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text('No se pudo eliminar'),
        ));
      }
    });
  }

  createUser(){
    if(_controllerNombre.text.isNotEmpty && _controllerEdad.text.isNotEmpty && genero!=null 
    && _controllerDireccion.text.isNotEmpty && departamentoNacimiento != null
     && ciudadNacimiento != null && _controllerOcupacion.text.isNotEmpty 
     && escolaridad != null && _controllerColegio.text.isNotEmpty && estadoCivil != null
     && pasatiempo != null && generoMusical != null && _controllerLugarResidencia.text.isNotEmpty 
     && capacidadFisica != null && capacidadCaminar != null){
      _createUser();

     }else{
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(
              content: new Text('Hay campos sin rellenar'),
            )
        );
     }
  }

   Future<Null> _createUser() async {
    try {
      var user = new Map();

      user["nombre"] = nombre;
      user["edad"] = edad;
      user["genero"] = genero;
      user["google_id"] = widget.googleId;
      user["registrado"] = true;
      user["direccion"] = direccion;
      user["departamento_nacimiento"] = departamentoNacimiento;
      user["ciudad_nacimiento"] = ciudadNacimiento;
      user["lugar_residencia"] = lugarResidencia;
      user["fecha_nacimiento"] = fechaNacimiento.toIso8601String();
      user["ocupacion_principal"] = ocupacion;
      user["escolaridad"] = escolaridad;
      user["colegio"] = colegio;
      user["estado_civil"] = estadoCivil;
      user["fecha_matrimonio"] = fechaMatrimonio.toIso8601String();
      user["pasatiempo"] = pasatiempo;
      user["genero_musical"] = generoMusical;
      user["capacidad_fisica"] = capacidadFisica;
      user["capacidad_caminar"] = capacidadCaminar;

      List<Map> familiares = [];

      for (int i = 0; i < person.length; i++) {
        familiares.add(
            {"nombre": person[i].nombre, "parentesco": person[i].parentesco});
      }
      user["familiares"] = familiares;
      print(user);

      final String requestBody = json.encode(user);
      print(requestBody);
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(URL + '/users/createUser'))
            ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
            ..headers.contentType = ContentType.JSON
            ..headers.contentLength = requestBody.length
            ..headers.chunkedTransferEncoding = false;
      request.write(requestBody);
      HttpClientResponse response = await request.close();
      print(
          json.decode(await response.transform(utf8.decoder).join())['nombre']);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new MyTabs(widget.googleId)));
    } catch (err) {
      print(err);
    }
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker(
      {Key key,
      this.labelText,
      this.selectedDate,
      this.selectedTime,
      this.selectDate,
      this.selectTime})
      : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: new DateTime(1918),
        lastDate: new DateTime(2101));
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = new TextStyle(fontSize: 17.0);
    return new Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Flexible(
          fit: FlexFit.loose,
          flex: 4,
          child: new _InputDropdown(
            labelText: labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(height: 24.0)
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: new InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ), //... ?
      ),
    );
  }
}
