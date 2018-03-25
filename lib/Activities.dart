import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clock/clock.dart' as clock;

import './utils/question.dart';
import './utils/quiz.dart';

import './UI/answer_button.dart';
import './UI/question_text.dart';
import './UI/correct_wrong_overlay.dart';

import './score_page.dart';



class QuizPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  QuizPage ({this.cameras});
  @override
  State createState() => new QuizPageState(cameras: cameras);
}

class QuizPageState extends State<QuizPage> {
  final List<CameraDescription> cameras;
  QuizPageState({this.cameras});
  CameraDescription cameraD;
  static const platform = const MethodChannel('samples.flutter.io/battery');
  bool opening = false;
  CameraController controller;
  String imagePath;
  int pictureCount = 0;

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Venus es un:", ["Planeta","Animal","Vegetal","Objeto"],"Planeta"),
    new Question("El cuarto día de la semana es:",["Lunes","Viernes","Jueves","Sábado"],"Jueves"),
    new Question("La madre de su madre es su:", ["Tia","Hermana","Madre","Abuela"],"Abuela")
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  var stopwatch = clock.getStopwatch();


  Future<Null> _sendEmotion(String path) async {
    try {
      await platform.invokeMethod('sendEmotion',<String, dynamic>{"path":path});
    } on PlatformException catch (e) {
      print("Failed to send emotion: '${e.message}'.");
    }
  }


  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
    stopwatch.start();
  }

  void handleAnswer(String answer) {
    capture();
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      stopwatch.stop();
      print((stopwatch.elapsedMilliseconds/1000).toString() + "seconds");
      stopwatch.reset();
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (CameraDescription cameraDescription in this.cameras) {
      if(cameraDescription.lensDirection == CameraLensDirection.front){
        cameraD = cameraDescription;
      }
    }
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is our main page
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new QuestionText(questionText, questionNumber),
            new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Row(children: <Widget>[
                        new AnswerButton(currentQuestion.options[0],currentQuestion.answer, () => handleAnswer(currentQuestion.options[0])),
                        new AnswerButton(currentQuestion.options[1],currentQuestion.answer, () => handleAnswer(currentQuestion.options[1])),
                      ]
                      ),
                      new Row(children: <Widget>[
                        new AnswerButton(currentQuestion.options[2],currentQuestion.answer, () => handleAnswer(currentQuestion.options[2])),
                        new AnswerButton(currentQuestion.options[3],currentQuestion.answer, () => handleAnswer(currentQuestion.options[3]))
                      ]
                      )
                    ]
            )
          ],
        ),
        overlayShouldBeVisible == true ? new CorrectWrongOverlay(
            isCorrect,
                () {
              if (quiz.length == questionNumber) {
                Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
                return;
              }
              currentQuestion = quiz.nextQuestion;
              this.setState(() {
                stopwatch.start();
                overlayShouldBeVisible = false;
                questionText = currentQuestion.question;
                questionNumber = quiz.questionNumber;
              });
            }
        ) : new Container()
      ],
    );
  }

  Future<Null> capture() async {
    final CameraController tempController = controller;
    controller = null;
    await tempController?.dispose();
    controller =
    new CameraController(cameraD, ResolutionPreset.high);
    await controller.initialize();
    setState(() {});
    if (controller.value.hasError) {
      debugPrint('Camera error ${controller.value.errorDescription}');
    }
    if (controller.value.isStarted) {
      final Directory tempDir = await getTemporaryDirectory();
      if (!mounted) {
        return;
      }
      final String tempPath = tempDir.path;
      final String path = '$tempPath/picture${pictureCount++}.jpg';
      await controller.capture(path);
      if (!mounted) {
        return;
      }
      setState(
            () {
          imagePath = path;
          _sendEmotion(path);
        },
      );
    }
  }
}