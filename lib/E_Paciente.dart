import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class ExamenPaciente extends StatefulWidget {

  @override
  _ExamenPaciente createState() => new _ExamenPaciente();
}

class _ExamenPaciente extends State<ExamenPaciente> {
  int radioValue = 0;
  bool switchValue = false;
  DateTime _fromDate = new DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  final List<String> _allDepartments = <String>[
    'Antioquia', 'Cundinamarca', 'Santader'
  ];
  String _department = null;
  final List<String> _allCities = <String>[
    'Medellin', 'Bogota', 'Cali'
  ];
  String _city = null;

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new DropdownButtonHideUnderline(
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new ListView(
            padding: new EdgeInsets.all(35.0),
            children: <Widget>[
              new Text("Memoria:", style: new TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25.0)),
              new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("1. ¿Tiene Ud. problemas con su memoria?",
                        style: new TextStyle(fontSize: 18.0)),
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
                  ]),
              new Text("2. ¿Cuándo nació?",
                  style: new TextStyle(fontSize: 18.0)),
              new _DateTimePicker(
                labelText: 'Fecha',
                selectedDate: _fromDate,
                selectedTime: _fromTime,
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                },
                selectTime: (TimeOfDay time) {
                  setState(() {
                    _fromTime = time;
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
                  right: 0.0, top: 12.0, left: 0.0, bottom: 0.0),
                    child: new Text("4. ¿En que colegio estudió?",
                      style: new TextStyle(fontSize: 18.0)))
            ],
          )
          ,
        )
        ,
      )
      ,
    );
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
        firstDate: new DateTime(2015, 8),
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
        const SizedBox(width: 12.0),
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