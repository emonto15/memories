import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:memories/main.dart';
import 'package:memories/Constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var httpClient = new HttpClient();
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();

  Color gradientStart =
      new Color(0xFF9575CD); //Change start gradient color here
  Color gradientEnd = new Color(0xFF5E35B1); //Change end gradient color here
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
            textDirection: TextDirection.ltr,
            child: new Scaffold(
                resizeToAvoidBottomPadding: true,
                key: _scaffoldKey,
                body: new Container(
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [gradientStart, gradientEnd],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp)),
                    child: new Stack(fit: StackFit.expand, children: <Widget>[
                      new Theme(
                        data: new ThemeData(
                            primaryColor: Colors.white,
                            textSelectionColor: Colors.white,
                            hintColor: Colors.white10,
                            accentColor: Colors.white,
                            inputDecorationTheme: new InputDecorationTheme(
                              hintStyle: new TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                              labelStyle: new TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            )),
                        isMaterialAppTheme: true,
                        child: new ListView(
                          controller: scrollController,
                          children: <Widget>[
                            new AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.only(
                                    top: 150.0, bottom: 70.0),
                                child: new Image(
                                  image: new AssetImage('assets/logo.webp'),
                                  width: _iconAnimation.value * 90.0,
                                  height: _iconAnimation.value * 90.0,
                                )),
                            new AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 500.0),
                              child: new Form(
                                autovalidate: true,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      padding: const EdgeInsets.only(top: 60.0),
                                      child: new MaterialButton(
                                        height: 50.0,
                                        minWidth: 150.0,
                                        color: gradientEnd,
                                        splashColor: gradientStart,
                                        textColor: Colors.white,
                                        child: new Center(
                                            child: new Row(children: <Widget>[
                                          new Container(
                                              width: 60.0,
                                              child: new Image(
                                                  image: new AssetImage(
                                                      'assets/google-logo.webp'),
                                                  width: 25.0,
                                                  height: 25.0)),
                                          new Text("Iniciar Sesion",
                                              style: new TextStyle(
                                                  fontSize: 20.0)),
                                        ])),
                                        onPressed: () => _handleSignIn(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ])))));
  }

  Future<Null> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
     var  currentUser = new Map();
      currentUser["google_id"] = _googleSignIn.currentUser.id;

      final String requestBody = json.encode(currentUser);
      print(requestBody);
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(URL+'/users/login'))
        ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
        ..headers.contentType = ContentType.JSON
        ..headers.contentLength = requestBody.length
        ..headers.chunkedTransferEncoding = false;
      request.write(requestBody);
      HttpClientResponse response = await request.close();
      print(json.decode(await response.transform(utf8.decoder).join())['registrado']);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new MyTabs()));
    } catch (err) {
      print(err);
    }
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }
}
