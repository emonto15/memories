
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/UI/control_Button.dart';
import 'package:memories/Constants.dart';

class Musicoterapia extends StatefulWidget {
  @override
  State createState() => new MusicoterapiaState();
}

class MusicoterapiaState extends State<Musicoterapia> {
  final MethodChannel _channel = new MethodChannel('co.edu.eafit.dis.p2.memories');
  bool playing = false;
  bool firstPlay = true;
  String song;
  String token;
  String _songName = '----';
  String _songArtist = '----';
  String _songArt = SPOTIFY_ART;

  void getToken() async {
    String a = await _channel.invokeMethod('spotifyGetToken');
    setState(() {
      token = a;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();

  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                          child: new Container(
                              child: new Image.network(
                        _songArt,
                        width: screenWidth * 0.20,
                        height: screenWidth * 0.20,
                      )))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                          child: new Text(
                        _songName,
                        style: new TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                          child: new Text(
                        _songArtist,
                        style: new TextStyle(fontSize: 20.0),
                      ))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new ControlButton(Icons.skip_previous, () => prev()),
                      playing
                          ? new ControlButton(
                              Icons.pause_circle_outline, () => stop())
                          : new ControlButton(
                              Icons.play_circle_outline, () => play()),
                      new ControlButton(Icons.skip_next, () => next()),
                    ],
                  ),
                ])));
  }

  void play() async {
    print(token);

    String response = await _channel
        .invokeMethod('spotifyPlay', <String, dynamic>{"isFirstPlay": firstPlay});
    List<String> song = response.split(",");
    setState(() {
      firstPlay = false;
      playing = true;
      _songName = song[0];
      _songArtist = song[1];
      _songArt = song[2];
    });
  }

  void next() async {
    String response = await _channel.invokeMethod('spotifyNext');
    List<String> song = response.split(",");
    setState(() {
      playing = true;
      _songName = song[0];
      _songArtist = song[1];
      _songArt = song[2];
    });
  }

  void prev() async {
    String response = await _channel.invokeMethod('spotifyPrev');
    List<String> song = response.split(",");
    setState(() {
      playing = true;
      _songName = song[0];
      _songArtist = song[1];
      _songArt = song[2];
    });
  }

  void stop() async {
    await _channel.invokeMethod('spotifyPause');
    setState(() {
      playing = false;
    });
  }
}
