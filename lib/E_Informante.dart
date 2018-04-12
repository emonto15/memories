import 'package:flutter/material.dart';

class ExamenInformante extends StatefulWidget {
  @override
  _ExamenInformanteState createState() => new _ExamenInformanteState();
}

class _ExamenInformanteState extends State<ExamenInformante> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    showInSnackBar('Se han enviado los datos correctamente.');
  }

  final List<String> _yesNo = <String>['Si', 'No'];

  final List<String> _yesNose = <String>['Si', 'No', 'No sé'];

  final List<String> _yesNoseAplica = <String>[
    'Si',
    'No',
    'No sé',
    'No aplica'
  ];

  final List<String> _yesAplica = <String>['Si', 'No', 'No aplica'];

  final List<String> _mente = <String>[
    'Generalmente',
    'A veces',
    'Raramente o nunca'
  ];

  final List<String> _menteNose = <String>[
    'Generalmente',
    'A veces',
    'Raramente o nunca',
    'No sé'
  ];

  final List<String> _menteNoseAplica = <String>[
    'Generalmente',
    'A veces',
    'Raramente o nunca',
    'No sé',
    'No aplica'
  ];

  final List<String> _capacidad = <String>[
    'Tan buena como ha sido siempre',
    'Regular',
    'No tiene ninguna capacidad',
    'Buena, pero no tan buena como lo era antes',
    'Pobre'
  ];

  final List<String> _perdida = <String>[
    'Sin pérdida',
    'Algo de pérdida',
    'Pérdida severa'
  ];

  final List<String> _antes = <String>[
    'Tan bien como antes',
    'Peor que antes debido a problemas en el pensamiento',
    'Peor que antes, por otra razón'
  ];
  final List<String> _desempe = <String>[
    'Desempeño completamente dependiente de otra persona (no puede hacer nada sin supervisión)',
    'Desempeño muy limitado(Realiza actividades simples, tales como tender la cama,\nsolamente bajo estrecha supervisión)',
    'Se desempeña sólo en actividades limitadas (Bajo cierta supervisión, lava la vajilla\ncon una limpieza aceptable; pone la mesa)',
    'Peor que antes, por otra razón',
    'Se desempeña independientemente en algunas actividades (Maneja electrodomésticos,\ntales como una aspiradora; prepara comidas simples)',
    'Se desempeña en actividades habituales, pero no con el nivel usual',
    'Se desempeña normalmente en actividades habituales'
  ];

  final List<String> _p1 = <String>[
    'Sin ayuda',
    'Ocasionalmente botones mal abotonados, etc.',
    'Secuencia equivocada. Cosas frecuentemente olvidadas',
    'Incapaz de vestirse solo/a'
  ];

  final List<String> _p2 = <String>[
    'Sin ayuda',
    'Necesita recordatorios',
    'A veces necesita ayuda',
    'Siempre o casi siempre necesita ayuda'
  ];

  final List<String> _p3 = <String>[
    'Limpio; utiliza los utensilios correctos',
    'Desordenado; Solo usa cuchara',
    'Solo puede comer sólidos simples sin supervisión',
    'Se le debe dar de comer en todo momento'
  ];

  final List<String> _p4 = <String>[
    'Control completo normal',
    'Ocasionalmente moja la cama',
    'Frecuentemente moja la cama',
    'Incontinencia doble'
  ];

  //Variables para memoria
  String _1m, _1am, _2m, _3m, _4m, _5m, _6m, _7m, _8m;

  //Variables para orientación
  String _1o, _2o, _3o, _4o, _5o, _6o, _7o, _8o;

  //Variables para juicio y resolución de problemas
  String _1j, _2j, _3j, _4j, _5j, _6j;

  //Variables para actividades comunitarias
  String _1c, _2c, _3c, _4c, _4ac, _4bc, _5c, _6c, _7c, _8c, _9c, _10c;

  //Variables para actividades domesticas
  String _1d;

  //Variables para cuidado personal
  String _1p, _2p, _3p, _4p;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
            title: new Center(child: new Text("Informante")),
            backgroundColor: new Color(0xFF7E57C2),
            automaticallyImplyLeading: false),
        body: new DropdownButtonHideUnderline(
            child: new Container(
          padding: new EdgeInsets.all(35.0),
          child: new ListView(
            children: <Widget>[
              //MEMORIA
              new Text("Memoria:",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0)),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "1. ¿Presenta él/ella problemas con su memoria o su pensamiento?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _1m == null,
                  child: new DropdownButton<String>(
                      value: _1m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _1m = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text(
                      "1a. En caso afirmativo, ¿es éste un problema constante (a diferencia de esporádico)?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                          labelText: 'Respuesta:', hintText: ''),
                      isEmpty: _1am == null,
                      child: new DropdownButton<String>(
                          value: _1am,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _1am = newValue;
                            });
                          },
                          items: _yesNo.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "2. ¿Puede él/ella recordar eventos recientes?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                      labelText: 'Respuesta:', hintText: ''),
                  isEmpty: _2m == null,
                  child: new DropdownButton<String>(
                      value: _2m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _2m = newValue;
                        });
                      },
                      items: _mente.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "3. ¿Puede él/ella recordar una lista breve de artículos (compras)?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _3m == null,
                  child: new DropdownButton<String>(
                      value: _3m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _3m = newValue;
                        });
                      },
                      items: _mente.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "4. ¿Se ha registrado algún deterioro en su memoria durante el último año?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _4m == null,
                  child: new DropdownButton<String>(
                      value: _4m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _4m = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "5. ¿Se encuentra su memoria deteriorada a tal punto que habría interferido con la realización de sus actividades cotidianas habituales de años atrás (o actividades previas a la jubilación)? (opinión de fuentes colaterales).",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _5m == null,
                  child: new DropdownButton<String>(
                      value: _5m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _5m = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "6. ¿Se olvida él/ella completamente de un evento importante (ej., viaje, fiesta, matrimonio familiar) a pocas semanas del evento?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _6m == null,
                  child: new DropdownButton<String>(
                      value: _6m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _6m = newValue;
                        });
                      },
                      items: _mente.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "7. ¿Se olvida él/ella de detalles relevantes del evento importante?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _7m == null,
                  child: new DropdownButton<String>(
                      value: _7m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _7m = newValue;
                        });
                      },
                      items: _mente.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "8. ¿Se olvida él/ella completamente de información importante del pasado lejano (ej. fecha de cumpleaños, fecha de matrimonio, lugar de trabajo)?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _8m == null,
                  child: new DropdownButton<String>(
                      value: _8m,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _8m = newValue;
                        });
                      },
                      items: _mente.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              //ORIENTACIÓN
              new Container(
                  padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Orientación:",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "¿Con qué frecuencia sabe él/ella exactamente:",
                      style: new TextStyle(fontSize: 19.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("1. la fecha del día?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _1o == null,
                      child: new DropdownButton<String>(
                          value: _1o,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _1o = newValue;
                            });
                          },
                          items: _menteNose.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("2. el mes?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _2o == null,
                      child: new DropdownButton<String>(
                          value: _2o,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _2o = newValue;
                            });
                          },
                          items: _menteNose.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("3. el año?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _3o == null,
                      child: new DropdownButton<String>(
                          value: _3o,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _3o = newValue;
                            });
                          },
                          items: _menteNose.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("4. el día de la semana?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                padding: new EdgeInsets.only(left: 20.0),
                child: new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _4o == null,
                  child: new DropdownButton<String>(
                    value: _4o,
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        _4o = newValue;
                      });
                    },
                    items: _menteNose.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "5. ¿Presenta él/ella dificultad para relacionar acontecimientos en el tiempo (cuándo ocurrieron unos eventos en relación con los otros)?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Respuesta:',
                  hintText: '',
                ),
                isEmpty: _5o == null,
                child: new DropdownButton<String>(
                  value: _5o,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _5o = newValue;
                    });
                  },
                  items: _menteNose.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "6. ¿Puede él/ella orientarse en calles que le son conocidas?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Respuesta:',
                  hintText: '',
                ),
                isEmpty: _6o == null,
                child: new DropdownButton<String>(
                  value: _6o,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _6o = newValue;
                    });
                  },
                  items: _menteNose.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "7. ¿Con qué frecuencia sabe él/ella cómo llegar de un lugar a otro cuando se encuentra fuera de su vecindario?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Respuesta:',
                  hintText: '',
                ),
                isEmpty: _7o == null,
                child: new DropdownButton<String>(
                  value: _7o,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _7o = newValue;
                    });
                  },
                  items: _menteNose.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "8. ¿Con qué frecuencia puede él/ella orientarse dentro de su casa?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Respuesta:',
                  hintText: '',
                ),
                isEmpty: _8o == null,
                child: new DropdownButton<String>(
                  value: _8o,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _8o = newValue;
                    });
                  },
                  items: _menteNose.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),

              //JUICIO
              new Container(
                  padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Juicio y resolución de problemas:",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "1. En general, si Ud. tuviera que evaluar la capacidad de él/ella para resolver problemas en este momento, Ud. la consideraría:",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _1j == null,
                  child: new DropdownButton<String>(
                      value: _1j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _1j = newValue;
                        });
                      },
                      items: _capacidad.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "2. Evalúe la capacidad de él/ella para manejar pequeñas sumas de dinero (ej. dar cambio, dejar una pequeña propina):",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _2j == null,
                  child: new DropdownButton<String>(
                      value: _2j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _2j = newValue;
                        });
                      },
                      items: _perdida.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "3. Evalúe la capacidad de él/ella para manejar transacciones financieras o de negocios complicadas (ej. balancear una chequera, pagar cuentas):",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _3j == null,
                  child: new DropdownButton<String>(
                      value: _3j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _3j = newValue;
                        });
                      },
                      items: _perdida.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "4. ¿Puede él/ella manejar una emergencia doméstica (ej. gotera en las cañerías, pequeño incendio)?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _4j == null,
                  child: new DropdownButton<String>(
                      value: _4j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _4j = newValue;
                        });
                      },
                      items: _antes.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "5. ¿Puede él/ella comprender situaciones o explicaciones?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _5j == null,
                  child: new DropdownButton<String>(
                      value: _5j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _5j = newValue;
                        });
                      },
                      items: _menteNose.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "6. ¿Se comporta apropiadamente (es decir, como usualmente se comportaba antes de la aparición de su enfermedad) en situaciones sociales e interacciones con otra gente?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _6j == null,
                  child: new DropdownButton<String>(
                      value: _6j,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _6j = newValue;
                        });
                      },
                      items: _menteNose.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              //Actividades comunitarias
              new Container(
                  padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Actividades comunitarias:",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text("1. ¿Él/Ella sigue trabajando?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _1c == null,
                  child: new DropdownButton<String>(
                      value: _1c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _1c = newValue;
                        });
                      },
                      items: _yesAplica.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "2. ¿Problemas con la memoria o el pensamiento de él/ella contribuyeron a su decisión de jubilarse?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _2c == null,
                  child: new DropdownButton<String>(
                      value: _2c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _2c = newValue;
                        });
                      },
                      items: _yesNoseAplica.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "3. ¿Él/Ella presenta dificultades significativas en el trabajo debido a problemas con su memoria o su pensamiento?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _3c == null,
                  child: new DropdownButton<String>(
                      value: _3c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _3c = newValue;
                        });
                      },
                      items: _menteNoseAplica.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text("4. ¿Condujo él/ella alguna vez un carro?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _4c == null,
                  child: new DropdownButton<String>(
                      value: _4c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _4c = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("4a. ¿Actualmente, él/ella conduce un carro?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                          labelText: 'Respuesta:', hintText: ''),
                      isEmpty: _4ac == null,
                      child: new DropdownButton<String>(
                          value: _4ac,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _4ac = newValue;
                            });
                          },
                          items: _yesNo.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text(
                      "4b. Si la respuesta es negativa, ¿se debe esto a problemas con su memoria o su pensamiento?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                          labelText: 'Respuesta:', hintText: ''),
                      isEmpty: _4bc == null,
                      child: new DropdownButton<String>(
                          value: _4bc,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _4bc = newValue;
                            });
                          },
                          items: _yesNo.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "5. Si él/ella todavía conduce, ¿existen problemas o riesgos debido a un pensamiento pobre?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _5c == null,
                  child: new DropdownButton<String>(
                      value: _5c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _5c = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "6. ¿Es él/ella todavía capaz de salir a comprar lo que necesita en forma independiente?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _6c == null,
                  child: new DropdownButton<String>(
                      value: _6c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _6c = newValue;
                        });
                      },
                      items: _menteNose.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "7. ¿Es él/ella capaz de llevar a cabo actividades fuera del hogar en forma independiente?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _7c == null,
                  child: new DropdownButton<String>(
                      value: _7c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _7c = newValue;
                        });
                      },
                      items: _menteNose.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "8. ¿Asiste él/ella a funciones sociales fuera del hogar familiar?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _8c == null,
                  child: new DropdownButton<String>(
                      value: _8c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _8c = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "9. ¿Alguien que no conozca al sujeto y observara su comportamiento pensaría que éste/a se encuentra enfermo/a?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _9c == null,
                  child: new DropdownButton<String>(
                      value: _9c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _9c = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "10. Si el sujeto se encuentra en un hogar geriátrico, ¿participa activamente él/ella en actividades sociales (con participación intelectual)?",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _10c == null,
                  child: new DropdownButton<String>(
                      value: _10c,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _10c = newValue;
                        });
                      },
                      items: _yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              //Actividades domesticas
              new Container(
                  padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Actividades domésticas:",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "1. ¿En qué nivel es él/ella capaz de realizar tareas domésticas? (No es necesario preguntarle directamente al informante).",
                      style: new TextStyle(fontSize: 18.0))),
              new InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Respuesta:',
                    hintText: '',
                  ),
                  isEmpty: _1d == null,
                  child: new DropdownButton<String>(
                      value: _1d,
                      isDense: true,
                      onChanged: (String newValue) {
                        setState(() {
                          _1d = newValue;
                        });
                      },
                      items: _desempe.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList())),

              //Cuidado personal
              new Container(
                  padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Cuidado personal:",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0),
                  child: new Text(
                      "1. ¿Cuál es su estimación de la capacidad mental de él/ella en las siguientes áreas?",
                      style: new TextStyle(fontSize: 19.0))),

              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("1a. Vestirse",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _1p == null,
                      child: new DropdownButton<String>(
                          value: _1p,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _1p = newValue;
                            });
                          },
                          items: _p1.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("1b. Lavado. Aseo",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _2p == null,
                      child: new DropdownButton<String>(
                          value: _2p,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _2p = newValue;
                            });
                          },
                          items: _p2.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("1c. Hábitos de alimentación",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _3p == null,
                      child: new DropdownButton<String>(
                          value: _3p,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _3p = newValue;
                            });
                          },
                          items: _p3.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new Text("1d. Control de esfinteres",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(
                  padding: new EdgeInsets.only(top: 10.0, left: 20.0),
                  child: new InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Respuesta:',
                        hintText: '',
                      ),
                      isEmpty: _1d == null,
                      child: new DropdownButton<String>(
                          value: _1d,
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _1d = newValue;
                            });
                          },
                          items: _p4.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList()))),
              new Container(
                  padding: new EdgeInsets.all(20.0),
                  child: new Center(
                    child: new RaisedButton(
                      color: new Color(0xFF7E57C2),
                      child: new Text('Enviar',
                          style: new TextStyle(
                              color: Colors.white, fontSize: 18.0)),
                      onPressed: _handleSubmitted,
                    ),
                  ))
            ],
          ),
        )));
  }
}
