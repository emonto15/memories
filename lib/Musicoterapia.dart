import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memories/UI/control_Button.dart';

class Musicoterapia extends StatefulWidget {
  @override
  State createState() => new MusicoterapiaState();
}

class MusicoterapiaState extends State<Musicoterapia> {
  final MethodChannel _channel = MethodChannel('co.edu.eafit.dis.p2.memories');
  final EventChannel stream =
      EventChannel('co.edu.eafit.dis.p2.memories/event');
  StreamSubscription _metadataSubscription = null;
  bool playing = false;
  bool firstPlay = true;
  String song;
  String token;
  String _songName = '----';
  String _songArtist = '----';
  String _songArt =
      'http://backgroundcheckall.com/wp-content/uploads/2017/12/spotify-logo-transparent-background-1.png';

  void getToken() async {
    String a = await _channel.invokeMethod('spotifyGetToken');
    setState(() {
      token = a;
    });
  }

  void _enableChannel() {
    if (_metadataSubscription == null) {
      _metadataSubscription =
          stream.receiveBroadcastStream().listen(_updateMetadata);
    }
  }

  void _disableChannel() {
    if (_metadataSubscription != null) {
      _metadataSubscription.cancel();
      _metadataSubscription = null;
    }
  }

  void _updateMetadata(metadata) {
    debugPrint("Timer $metadata");
  }

  @override
  void initState() {
    super.initState();
    logging();
    getToken();

    _enableChannel();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeigth = MediaQuery.of(context).size.height;
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

  void logging() async {
    String a = await _channel.invokeMethod('spotifyLogin');
    String token1 = await _channel.invokeMethod('spotifyGetToken');
    setState(() {
      print(token1);
      token = token1;
    });
  }

  void play() async {
    print(token);
    print("JOCO");

    String response = await _channel
        .invokeMethod('spotifyPlay', <String, dynamic>{"isFirstPlay": firstPlay});
    print(response);
    print("DAMI");
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
    print("CALLESE");
    await _channel.invokeMethod('spotifyPause');
    print("ELQUE");
    setState(() {
      playing = false;
    });
  }
}
