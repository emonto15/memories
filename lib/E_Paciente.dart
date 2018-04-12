import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:memories/E_Informante.dart' as informante;

class ExamenPaciente extends StatefulWidget {

  @override
  _ExamenPaciente createState() => new _ExamenPaciente();
}

class _ExamenPaciente extends State<ExamenPaciente> {
  final TextEditingController college_controller = new TextEditingController();
  final TextEditingController ocupation_controller = new TextEditingController();
  final TextEditingController milesdep_controller = new TextEditingController();
  final TextEditingController monedasde_controller = new TextEditingController();
  final TextEditingController resta_controller = new TextEditingController();

  int radioValue = 0;
  bool switchValue = false;
  DateTime birth_fromDate = new DateTime.now();
  TimeOfDay birth_fromTime = const TimeOfDay(hour: 7, minute: 28);
  DateTime actual_fromDate = new DateTime.now();
  TimeOfDay actual_fromTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _allDepartments = <String>[
    'Antioquia', 'Cundinamarca', 'Santader'
  ];
  String _department;
  final List<String> _allCities = <String>[
    'Medellin', 'Bogota', 'Cali'
  ];
  String _city;
  final List<String> _weekDays = <String>[
    'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
  ];
  String _weekDay;
  final List<String> _monthsOfYear = <String>[
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  String _monthOfYear;
  final List<String> _years = <String>[
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024'
  ];
  String _year;
  final List<String> _towns = <String>[
    'Abejorral',
    'Bogota',
    'Medellin',
    'Envigado',
    'Itagui',
    'Cali',
    'New York',
    'San Rafael'
  ];
  String _town;
  final List<String> _constructionElements = <String>[
    'Cemento',
    'Ladrillos',
    'Casco',
    'Flecha',
    'Pala',
    'Carretilla'
  ];
  String _contructionElement;

  final List<String> _beachElements = <String>[
    'Linterna',
    'Chaqueta',
    'Botas',
    'Vestido de baño',
    'Espejo'
  ];
  String _beachElement;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Center(child: new Text("Paciente")),
          backgroundColor: new Color(0xFF7E57C2),
          automaticallyImplyLeading: false,
      ),
      key: _scaffoldKey,
      body: new DropdownButtonHideUnderline(
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new ListView(
            padding: new EdgeInsets.all(35.0),
            children: <Widget>[
              new Text("Memoria:", style: new TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25.0)),
              new Container(padding: new EdgeInsets.only(top: 10.0),
                  child: new Text("1. ¿Tiene Ud. problemas con su memoria?",
                      style: new TextStyle(fontSize: 18.0))),
              new Container(padding: new EdgeInsets.only(top: 5.0, bottom: 2.0),
                  child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Radio<int>(
                            value: 0,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged
                        ),
                        const Text("Si")
                        ,
                        new Radio<int>(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: handleRadioValueChanged
                        ),
                        const Text("No")
                      ]))
              ,
              new Text("2. ¿Cuándo nació?",
                  style: new TextStyle(fontSize: 18.0)),
              new _DateTimePicker(
                labelText: 'Fecha',
                selectedDate: birth_fromDate,
                selectedTime: birth_fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    birth_fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    birth_fromTime = time;
                  });
                },
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 12.0, left: 0.0, bottom: 0.0),
                  child: new Text("3. ¿Dónde nació?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Departamento',
                  hintText: '',
                ),
                isEmpty: _department == null,
                child: new DropdownButton<String>(
                  value: _department,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _department = newValue;
                    });
                  },
                  items: _allDepartments.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  hintText: '',
                ),
                isEmpty: _city == null,
                child: new DropdownButton<String>(
                  value: _city,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _city = newValue;
                    });
                  },
                  items: _allCities.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text("4. ¿En qué colegio estudió?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new TextField(
                controller: college_controller,
                decoration: new InputDecoration(
                  hintText: 'Colegio',
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .display1
                    .copyWith(fontSize: 18.0),
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "5. ¿Cuál era su principal ocupación o trabajo?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new TextField(
                  controller: ocupation_controller,
                  decoration: new InputDecoration(
                      hintText: 'Ocupación'
                  )),
              new Container(padding: new EdgeInsets.only(top: 60.0),
                  child: new Text("Orientación:", style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0))
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "1. ¿Qué fecha es hoy?",
                      style: new TextStyle(fontSize: 18.0))),
              new _DateTimePicker(
                labelText: 'Fecha',
                selectedDate: actual_fromDate,
                selectedTime: actual_fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    actual_fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    actual_fromTime = time;
                  });
                },
              ),
              new Container(
                  padding: new EdgeInsets.only(
                      right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "2. ¿Qué día de la semana es hoy?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Dia',
                  hintText: '',
                ),
                isEmpty: _weekDay == null,
                child: new DropdownButton<String>(
                  value: _weekDay,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _weekDay = newValue;
                    });
                  },
                  items: _weekDays.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "3. ¿En qué mes estamos?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Mes',
                  hintText: '',
                ),
                isEmpty: _monthOfYear == null,
                child: new DropdownButton<String>(
                  value: _monthOfYear,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _monthOfYear = newValue;
                    });
                  },
                  items: _monthsOfYear.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "4. ¿En qué año estamos?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Año',
                  hintText: '',
                ),
                isEmpty: _year == null,
                child: new DropdownButton<String>(
                  value: _year,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _year = newValue;
                    });
                  },
                  items: _years.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "5. ¿En qué pueblo o ciudad estamos?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Pueblo o ciudad',
                  hintText: '',
                ),
                isEmpty: _town == null,
                child: new DropdownButton<String>(
                  value: _town,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _town = newValue;
                    });
                  },
                  items: _towns.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
              new Container(padding: new EdgeInsets.only(top: 60.0),
                  child: new Text(
                      "Resolución de problemas:", style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25.0))
              ),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "1. ¿Cuántos miles de pesos hay en un millon?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new TextField(
                  controller: milesdep_controller,
                  decoration: new InputDecoration(
                      hintText: 'Escribe el resultado en miles de pesos.'
                  )),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "2. ¿Cuántas monedas de 50 pesos hay en \$1,350?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new TextField(
                  controller: monedasde_controller,
                  decoration: new InputDecoration(
                      hintText: 'Escribe el resultado en miles de pesos.'
                  )),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "3. ¿Restarle 3 a 20, sumarle 5 y luego restarle dos me da?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new TextField(
                  controller: resta_controller,
                  decoration: new InputDecoration(
                      hintText: 'Escribe el resultado en miles de pesos.'
                  )),
              new Container(padding: new EdgeInsets.only(
                  right: 0.0, top: 20.0, left: 0.0, bottom: 0.0),
                  child: new Text(
                      "5. Imagínese que va a pasar un día en la playa, ¿Qué deberá llevar?",
                      style: new TextStyle(fontSize: 18.0)))
              ,
              new InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Opciones',
                  hintText: '',
                ),
                isEmpty: _beachElement == null,
                child: new DropdownButton<String>(
                  value: _beachElement,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _beachElement = newValue;
                    });
                  },
                  items: _beachElements.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
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
              ))
            ],
          )
          ,
        )
        ,
      )
      ,
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value)
    ));
  }

  void _handleSubmitted() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => informante.ExamenInformante()));
  }
}


class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime
  }) : super(key: key);

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
        lastDate: new DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      selectDate(picked);
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime
    );
    if (picked != null && picked != selectedTime)
      selectTime(picked);
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
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed }) : super(key: key);

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
                color: Theme
                    .of(context)
                    .brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70
            ),
          ],
        ),//... ?
      ),
    );
  }
}