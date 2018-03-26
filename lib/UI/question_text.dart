import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {

  final String _question;
  final int _questionNumber;
  bool hasImage;
  String imagePath;

  QuestionText(this._question, this._questionNumber, this.hasImage, this.imagePath);

  @override
  State createState() => new QuestionTextState(hasImage: hasImage, imagePath: imagePath);
}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {
  final bool hasImage;
  final String imagePath;
  QuestionTextState({this.hasImage, this.imagePath});
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState() {
    super.initState();
    _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.bounceOut);
    _fontSizeAnimation.addListener(() => this.setState(() {}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.hasImage == true){
      return new Material(
        color: new Color(0xFF7E57C2),
        child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 70.0),
            child: new Center(
              child: new Column(children: <Widget>[
                new Text(widget._question,
                  style: new TextStyle(fontSize: _fontSizeAnimation.value * 50, fontWeight: FontWeight.bold, color: Colors.white ),
                ),
                new Container(padding: new EdgeInsets.only(top:20.0),
                    child: new Image(image: new AssetImage(widget.imagePath), width: 200.0, height: 200.0)
                )
              ],
              ),
            )
        ),
      );
    }else{
      return new Material(
        color: new Color(0xFF7E57C2),
        child: new Padding(
            padding: new EdgeInsets.symmetric(vertical: 180.0),
            child: new Center(
              child: new Text(widget._question,
                  style: new TextStyle(fontSize: _fontSizeAnimation.value * 50, fontWeight: FontWeight.bold, color: Colors.white ),
                )
              ),
            )
        );
    }


  }
}