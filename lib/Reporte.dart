import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:memories/Constants.dart';

class Reporte extends StatefulWidget {
  final String googleId;
  Reporte(this.googleId);
  
  @override
  _ReporteState createState() => new _ReporteState();
}

class AreasBarra {
  final String year;
  final int clicks;
  final charts.Color color;

  AreasBarra(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class Emociones{
  final String emocion;
  final int promedioSemanal;
  final charts.Color color;


  Emociones(this.emocion, this.promedioSemanal, Color color) 
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
      

}

class AreasLine{
  final DateTime year;
  final int sales;
  final charts.Color color;


  AreasLine(this.year, this.sales, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
      

}

class _ReporteState extends State<Reporte> {
  var httpClient = new HttpClient();


  //variables diagrama de barra memoria, juicio y orientación, 0 es 100% y 3 es 0%
  //formula 100- valorRecibido*33.33333


  int memoriaBarras = 0;
  int orientacionBarras = 90;
  int juicioBarras = 0;

//variales diagrama de lineas
  static AreasLine inicioMemoria = new AreasLine(new DateTime(2018,5,1,), 0, Colors.purple);
  static AreasLine inicioMemoria2 = new AreasLine(new DateTime(2018,6,8,), 10, Colors.purple);
  static AreasLine inicioMemoria3 = new AreasLine(new DateTime(2018,7,16,), 20, Colors.purple);
  static AreasLine inicioJuicio = new AreasLine(new DateTime(2018,5,1), 0, Colors.deepPurple);
  static AreasLine inicioOrientacion = new AreasLine(new DateTime(2018,5,1), 0, Colors.purpleAccent);
  List<AreasLine> dataMemoriaLine = <AreasLine>[inicioMemoria];
  List<AreasLine> dataJuicioLine = <AreasLine>[inicioJuicio];
  List<AreasLine> dataOrientacionLine = <AreasLine>[inicioOrientacion];

//variables diagrama de barra emociones
  int felicidadBarras =50;
  int neutralBarras = 20;
  int tristeBarras = 80;

   
      

void initState() {
    super.initState();
    _getAreasData();
  
  }


  @override
  Widget build(BuildContext context) {

    //datos para las barras 
    var data = [
      new AreasBarra('Memoria', memoriaBarras, Colors.purple),
      new AreasBarra('Juicio', orientacionBarras, Colors.deepPurple),
      new AreasBarra('Orientacion', juicioBarras, Colors.purpleAccent),
    ];


  //datos para el diagrama de barras de las emociones semanal
  var emocionesData = [
    new Emociones("feliz", felicidadBarras, Colors.blue),
    new Emociones("Neutral", neutralBarras, Colors.green),
    new Emociones("Triste", tristeBarras, Colors.red),

  ];



    //series diagrama de lineas

    var seriesLine = [
      new charts.Series(
        domainFn: (AreasLine clickData, _) => clickData.year,
        measureFn: (AreasLine clickData, _) => clickData.sales,
        colorFn: (AreasLine clickData, _) => clickData.color,
        id: 'MemoriaLine',
        data: dataMemoriaLine
      ),
      new charts.Series(
        domainFn: (AreasLine clickData, _) => clickData.year,
        measureFn: (AreasLine clickData, _) => clickData.sales,
        colorFn: (AreasLine clickData, _) => clickData.color,
        id: 'JuicioLine',
        data: dataJuicioLine
      ),

     new charts.Series(
        domainFn: (AreasLine clickData, _) => clickData.year,
        measureFn: (AreasLine clickData, _) => clickData.sales,
        colorFn: (AreasLine clickData, _) => clickData.color,
        id: 'OrientacionLine',
        data: dataOrientacionLine
      ),
    ];

    


//serie diagrama de barras
    var series = [
      new charts.Series(
        domainFn: (AreasBarra clickData, _) => clickData.year,
        measureFn: (AreasBarra clickData, _) => clickData.clicks,
        colorFn: (AreasBarra clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

//series diagrama emociones barras

var seriesEmocines = [
      new charts.Series(
        domainFn: (Emociones emocionData, _) => emocionData.emocion,
        measureFn: (Emociones emocionData, _) => emocionData.promedioSemanal,
        colorFn: (Emociones emocionData, _) => emocionData.color,
        id: 'Emociones',
        data: emocionesData,
      ),
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartBarraEmociones = new charts.BarChart(
      seriesEmocines,
      animate: true,
    );

    var lineChar = new charts.TimeSeriesChart(
      seriesLine, 
      animate:true,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      dateTimeFactory: const charts.LocalDateTimeFactory()
      );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    var chartWidgetEmociones = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child:chartBarraEmociones,
      ),
    );


    var chartWidget2 = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: lineChar,
      ),
    );

    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0),
        child: new ListView(
          children: <Widget>[
            new Text("Reporte semanal porcentual de que tan bien esta el paciente en cada Area: ",
            style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,)),
            chartWidget,
            new Text("Reporte historico porcentual de que tan bien está el paciente en cada Area: ",
            style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,)),
            chartWidget2,
            new Text("Reporte semanal porcentual de emociones durante las actividades : ",
            style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold ,)),
            chartWidgetEmociones
          
          ],
        ),

      ),
    );
  }



  Future<Null> _getAreasData() async {
    try {
      var user = new Map();
      var nuevoMapa = new Map();
      //String URL="http://192.168.1.81:3000";

      //user["google_id"] = "1";
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
      nuevoMapa = json.decode(await response.transform(utf8.decoder).join());

      print(nuevoMapa);
      setState(() {
              var tam = nuevoMapa["test"].length;
      memoriaBarras = (100.0 - (nuevoMapa["test"][tam-1]["paciente"]["memoria"]*33.333333)).toInt();      
      orientacionBarras = (100 - (nuevoMapa["test"][tam-1]["paciente"]["orientacion"]*33.333333)).toInt();
      juicioBarras = (100 - (nuevoMapa["test"][tam-1]["paciente"]["juicio"]*33.333333)).toInt();
     
      print(nuevoMapa["test"][1]["fecha"]);
      for (int i = 0; i < tam; i++){
        var year = DateTime.parse(nuevoMapa["test"][i]["fecha"]).year;
        var month = DateTime.parse(nuevoMapa["test"][i]["fecha"]).month;
        var day = DateTime.parse(nuevoMapa["test"][i]["fecha"]).day;



        dataMemoriaLine.add(new AreasLine(new DateTime(year,month,day), (100.0 - nuevoMapa["test"][i]["paciente"]["memoria"]*33.333333).toInt(), Colors.purple));
        dataJuicioLine.add(new AreasLine(new DateTime(year,month,day), (100.0 - nuevoMapa["test"][i]["paciente"]["juicio"]*33.333333).toInt(), Colors.deepPurple));
        dataOrientacionLine.add(new AreasLine(new DateTime(year,month,day), (100.0 - nuevoMapa["test"][i]["paciente"]["orientacion"]*33.333333).toInt(), Colors.purpleAccent));

      }
      
            });
      

      print(memoriaBarras);

    } catch (err) {
      print(err);
    }
  }
}