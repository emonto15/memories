import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String _answer;
  final VoidCallback _onTap;
  final String _text;

  AnswerButton(this._text, this._answer, this._onTap);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return new Expanded(
      // true button
      child: new Material(
        color: Colors.white,
        child: new InkWell(
          onTap: () => _onTap(),
          child: new Container(
              width: screenWidth * 0.25,
              height: screenHeigth * 0.25,
              decoration: new BoxDecoration(
                  border: new Border.all(
                color: Colors.grey,
                width: screenWidth * 0.001,
              )),
              child: new Center(
                  child: new Container(
                      //decoration: new BoxDecoration(
                      //  border: new Border.all(color: Colors.white, width: 0.0),
                      //),
                      //padding: new EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),

                      child: new Center(
                          child: new Text(this._text,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 40.0)))))),
        ),
      ),
    );
  }
}
