import 'package:flutter/material.dart';

class ExamenInformante extends StatefulWidget {
  @override
  _ExamenInformanteState createState() => new _ExamenInformanteState();
}

class _ExamenInformanteState extends State<ExamenInformante> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(value)));
  }

  void _handleSubmitted() {
    print("mk aqui da");
   if (_1m == null || _2m == null || _3m == null ||_4m == null || _5m == null || _6m == null || _7m == null ||_8m == null ||_1o == null || _2o == null || _3o == null || _4o == null || _5o == null || _6o == null || _7o == null || _8o == null || _1j == null || _2j == null || _3j == null || _4j == null || _5j == null || _6j == null) {
      showInSnackBar('Porfavor rellene todos los datos');
    } else {
      int sumMemoryScore= 0, sumJudgeScore = 0, sumOrientationScore = 0, globalScore = 0;
      var memoryAnswers = [this._1m,this._2m,this._3m,this._4m,this._5m,this._6m,this._7m,this._8m];
      var judgeAnswers = [this._1j,this._2j,this._3j,this._4j,this._5j,this._6j];
      var orientationAnswers = [this._1o,this._2o,this._3o,this._4o,this._5o,this._6o,this._7o,this._8o];
      for(int i = 0; i<memoryAnswers.length; i++){
        sumMemoryScore = sumMemoryScore + getScore(memoryAnswers[i]);
        sumOrientationScore = sumOrientationScore + getScore(orientationAnswers[i]);
      }
      for(int i = 0; i<judgeAnswers.length; i++){
        sumJudgeScore = sumJudgeScore + getScore(judgeAnswers[i]);
      }
      globalScore = sumOrientationScore + sumJudgeScore + sumMemoryScore;

      double memoryScore= 3 - (sumMemoryScore/8);
      double orientationScore= 3 - (sumOrientationScore/8);
      double judgeScore= 3 - (sumJudgeScore/6);

      double totalScore = (memoryScore+orientationScore+judgeScore)/3;

      showInSnackBar("memoryScore: " + memoryScore.toString()+ "\n"+
          "JudgeScore: " +judgeScore.toString()+ "\n"+
          "orientationScore: " +orientationScore.toString()+ "\n"+
          "total: " +totalScore.toString()+ "\n"
      );
      //showInSnackBar('Se han enviado los datos correctamente.');
    }
  }

  int getScore(String value) {
    if (value == null){
        return 0;
    }else {
      if (value.contains("Generalmente")) {
        return 3;
      }
      if (value.contains("A veces")) {
        return 2;
      }
      if (value.contains("Raramente o nunca")) {
        return 1;
      }
      if (value.contains("Tan buena como ha sido siempre")) {
        return 3;
      }
      if (value.contains("Regular")) {
        return 1;
      }
      if (value.contains("Buena, pero no tan buena como lo era antes")) {
        return 2;
      }
      if (value.contains("Poca o nula")) {
        return 0;
      }
      if (value.contains("Sin pérdida")) {
        return 3;
      }
      if (value.contains("Algo de pérdida")) {
        return 2;
      }
      if (value.contains("Pérdida severa")) {
        return 1;
      }
      if (value.contains("Tan bien como antes")) {
        return 3;
      }
      if (value.contains("Peor que antes")) {
        return 0;
      }
      if (value.contains("Si")) {
        return 0;
      }
      if (value.contains("No")) {
        return 3;
      }
    }
    print(value);
    throw new Exception("No se puede puntuar esta opción");
  }

  final List<String> _yesNo = <String>['Si', 'No'];

  final List<String> _mente = <String>[
    'Generalmente',
    'A veces',
    'Raramente o nunca'
  ];

  final List<String> _menteNose = <String>[
    'Generalmente',
    'A veces',
    'Raramente o nunca'
  ];


  final List<String> _capacidad = <String>[
    'Tan buena como ha sido siempre',
    'Regular',
    'Buena, pero no tan buena como lo era antes',
    'Poca o nula'
  ];

  final List<String> _perdida = <String>[
    'Sin pérdida',
    'Algo de pérdida',
    'Pérdida severa'
  ];

  final List<String> _antes = <String>[
    'Tan bien como antes',
    'Peor que antes'
  ];

  //Variables para memoria
  String _1m, _2m, _3m, _4m, _5m, _6m, _7m, _8m;

  //Variables para orientación
  String _1o, _2o, _3o, _4o, _5o, _6o, _7o, _8o;

  //Variables para juicio y resolución de problemas
  String _1j, _2j, _3j, _4j, _5j, _6j;


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
                          "6. ¿Puede recordar él/ella completamente de un evento importante (ej., viaje, fiesta, matrimonio familiar) a pocas semanas del evento?",
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
                          "7. ¿Puede recordar él/ella de detalles relevantes del evento importante?",
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
                          "8. ¿Puede recordar él/ella completamente información importante del pasado lejano (ej. fecha de cumpleaños, fecha de matrimonio, lugar de trabajo)?",
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
                          "5. ¿Puede él/ella relacionar acontecimientos en el tiempo (cuándo ocurrieron unos eventos en relación con los otros)?",
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
