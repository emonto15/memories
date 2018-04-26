import 'dart:io';

import './question.dart';
import 'package:memories/tts.dart';

class Quiz {
  List<Question> _questions;
  int _currentCuestionIndex = -1;
  int _score = 0;

  Quiz(this._questions) {
    _questions.shuffle();
  }

  List<Question> get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentCuestionIndex+1;
  int get score => _score;

  Question get nextQuestion {
    _currentCuestionIndex++;
    if ( _currentCuestionIndex >= length ) return null;
    Tts.speak(_questions[_currentCuestionIndex].question);
    Tts.speak(_questions[_currentCuestionIndex].options[0]);
    Tts.speak(_questions[_currentCuestionIndex].options[1]);
    Tts.speak(_questions[_currentCuestionIndex].options[2]);
    Tts.speak(_questions[_currentCuestionIndex].options[3]);
    return _questions[_currentCuestionIndex];
  }

  void answer(bool isCorrect) {
    if (isCorrect) {
      _score++;
      Tts.speak( "La respuesta es correcta" );
    }else{
      Tts.speak( "La respuesta es incorrecta");
    }
  }
}