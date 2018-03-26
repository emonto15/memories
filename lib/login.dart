import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Color gradientStart = new Color(
      0xFF9575CD); //Change start gradient color here
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
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [gradientStart, gradientEnd],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                )
            ),
            child: new Stack(fit: StackFit.expand, children: <Widget>[
              new Theme(
                data: new ThemeData(
                    brightness: Brightness.dark,
                    inputDecorationTheme: new InputDecorationTheme(
                      // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                      labelStyle:
                      new TextStyle(color: Colors.white, fontSize: 20.0),
                    )
                ),
                isMaterialAppTheme: true,
                child: new ListView(
                  children: <Widget>[
                    new AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.only(
                            top: 150.0, bottom: 70.0),
                        child: new Image(
                          image: new AssetImage('assets/logo.webp'),
                          width: _iconAnimation.value * 90.0,
                          height: _iconAnimation.value * 90.0,
                        )
                    ),
                    new AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 500.0),
                      child: new Form(
                        autovalidate: true,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new TextFormField(
                              decoration: new InputDecoration(
                                  labelText: "Correo",
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            new TextFormField(
                              decoration: new InputDecoration(
                                labelText: "Contraseña",
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                            ),
                            new Container(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: new MaterialButton(
                                height: 50.0,
                                minWidth: 150.0,
                                color: new Color(0xFF5E35B1),
                                splashColor: new Color(0xFF9575CD),
                                textColor: Colors.white,
                                child: new Text("Iniciar Sesion",
                                    style: new TextStyle(fontSize: 20.0)),
                                onPressed:() => Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => new MyTabs())),
                              ),
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])
        )
    );
  }
}