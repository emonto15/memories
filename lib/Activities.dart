import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clock/clock.dart' as clock;
import 'package:collection/collection.dart';

import './utils/question.dart';
import './utils/quiz.dart';

import './UI/answer_button.dart';
import './UI/question_text.dart';
import './UI/correct_wrong_overlay.dart';

import './Score_page.dart';

class QuizPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String googleId = "";

  QuizPage({this.cameras,googleId});

  @override
  State createState() => new QuizPageState(cameras: cameras);
}

class QuizPageState extends State<QuizPage> {
  final List<CameraDescription> cameras;

  QuizPageState({this.cameras});
  Function eq = const ListEquality().equals;
  CameraDescription cameraD;
  static const platform = const MethodChannel('co.edu.eafit.dis.p2.memories');
  bool opening = false;
  CameraController controller;
  String imagePath;
  int pictureCount = 0;

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question(
        "Ordena la secuencia",
        ["Secarse", "Bañarse", "Vestirse", "Quitarse la ropa"],
        "",
        false,
        "",
        true,
        ["Quitarse la ropa", "Bañarse", "Secarse", "Vestirse"]),
    new Question(
        "¿Qué animal es este?",
        ["Cebra", "Caballo", "Unicornio", "Burro"],
        "Cebra",
        true,
        "assets/zebra256.webp",
        false,
        [""]),
    new Question(
        "Venus es un:",
        ["Planeta", "Animal", "Vegetal", "Objeto"],
        "Planeta",
        false,
        "",
        false,
        [""]),
    new Question(
        "El cuarto día de la semana es:",
        ["Lunes", "Viernes", "Jueves", "Sábado"],
        "Jueves",
        false,
        "",
        false,
        [""]),
    new Question(
        "La madre de su madre es su:",
        ["Tia", "Hermana", "Madre", "Abuela"],
        "Abuela",
        false,
        "",
        false,
        [""])
  ]);
  String questionText;
  int questionNumber;
  bool hasImage;
  String questionImagePath;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  var stopwatch = clock.getStopwatch();
  AnswerButton answer1;
  AnswerButton answer2;
  AnswerButton answer3;
  AnswerButton answer4;
  int contadorDeSecuencia;
  List<String> respuestaSecuencia;

  Future<Null> _sendEmotion(String path) async {
    try {
      await platform
          .invokeMethod('sendEmotion', <String, dynamic>{"path": path});
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
    hasImage = currentQuestion.hasImage;
    questionImagePath = currentQuestion.imageRoute;
    stopwatch.start();
    contadorDeSecuencia = 0;
    respuestaSecuencia = ["", "", "", ""];
    answer1 = new AnswerButton(
        currentQuestion.options[0],
        currentQuestion.answer,
            () => handleAnswer(currentQuestion.options[0]));

    answer2 = new AnswerButton(
        currentQuestion.options[1],
        currentQuestion.answer,
            () => handleAnswer(currentQuestion.options[1]));

    answer3 = new AnswerButton(
        currentQuestion.options[2],
        currentQuestion.answer,
            () => handleAnswer(currentQuestion.options[2]));

    answer4 = new AnswerButton(
        currentQuestion.options[3],
        currentQuestion.answer,
            () => handleAnswer(currentQuestion.options[3]));
  }

  void handleAnswer(String answer) {
    if (!currentQuestion.isSequence) {
      capture();
      isCorrect = (currentQuestion.answer == answer);
      quiz.answer(isCorrect);
      this.setState(() {
        stopwatch.stop();
        print((stopwatch.elapsedMilliseconds / 1000).toString() + "seconds");
        stopwatch.reset();
        overlayShouldBeVisible = true;
      });
    } else {
      this.setState(() {
        if(respuestaSecuencia.indexOf(answer)==-1) {
          if (currentQuestion.options.indexOf(answer) == 0) {
            answer1 = new AnswerButton(
                (contadorDeSecuencia+1).toString() + " - " +
                    currentQuestion.options[0],
                currentQuestion.answer,
                    () => handleAnswer(currentQuestion.options[0]));
            respuestaSecuencia[contadorDeSecuencia] =
            currentQuestion.options[0];
            contadorDeSecuencia++;
            if (contadorDeSecuencia == 4) {
              capture();
              isCorrect = (eq(currentQuestion.secuencia, respuestaSecuencia));
              quiz.answer(isCorrect);
              stopwatch.stop();
              print(
                  (stopwatch.elapsedMilliseconds / 1000).toString() +
                      "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 1) {
            answer2 = new AnswerButton(
                (contadorDeSecuencia+1).toString() + " - " +
                    currentQuestion.options[1],
                currentQuestion.answer,
                    () => handleAnswer(currentQuestion.options[1]));
            respuestaSecuencia[contadorDeSecuencia] =
            currentQuestion.options[1];
            contadorDeSecuencia++;
            if (contadorDeSecuencia == 4) {
              capture();
              isCorrect = (eq(currentQuestion.secuencia, respuestaSecuencia));
              quiz.answer(isCorrect);
              stopwatch.stop();
              print(
                  (stopwatch.elapsedMilliseconds / 1000).toString() +
                      "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 2) {
            answer3 = new AnswerButton(
                (contadorDeSecuencia+1).toString() + " - " +
                    currentQuestion.options[2],
                currentQuestion.answer,
                    () => handleAnswer(currentQuestion.options[2]));
            respuestaSecuencia[contadorDeSecuencia] =
            currentQuestion.options[2];
            contadorDeSecuencia++;
            if (contadorDeSecuencia == 4) {
              capture();
              isCorrect = ((eq(currentQuestion.secuencia, respuestaSecuencia)));
              quiz.answer(isCorrect);
              stopwatch.stop();
              print(
                  (stopwatch.elapsedMilliseconds / 1000).toString() +
                      "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 3) {
            answer4 = new AnswerButton(
                (contadorDeSecuencia+1).toString() + " - " +
                    currentQuestion.options[3],
                currentQuestion.answer,
                    () => handleAnswer(currentQuestion.options[3]));
            respuestaSecuencia[contadorDeSecuencia] =
            currentQuestion.options[3];
            contadorDeSecuencia++;
            if (contadorDeSecuencia == 4) {
              capture();
              isCorrect = ((eq(currentQuestion.secuencia, respuestaSecuencia)));
              quiz.answer(isCorrect);
              stopwatch.stop();
              print(
                  (stopwatch.elapsedMilliseconds / 1000).toString() +
                      "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
        }
      });
    }
    print
      (currentQuestion.options
        .
    indexOf
      (
        answer
    )
    );
  }


@override
Widget build(BuildContext context) {
  for (CameraDescription cameraDescription in this.cameras) {
    if (cameraDescription.lensDirection == CameraLensDirection.front) {
      cameraD = cameraDescription;
    }
  }
  var a = new Stack(
    fit: StackFit.passthrough,
    children: <Widget>[
      new Column(
        // This is our main page
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new QuestionText(
              questionText, questionNumber, hasImage, questionImagePath),
          new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Row(children: <Widget>[
                  answer1,
                  answer2
                ]),
                new Row(children: <Widget>[
                  answer3,
                  answer4
                ])
              ])
        ],
      ),
      overlayShouldBeVisible == true
          ? new CorrectWrongOverlay(isCorrect, () {
        if (quiz.length == questionNumber) {
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new ScorePage(quiz.score, quiz.length,widget.googleId)),
                  (Route route) => route == null);
          return;
        }
        currentQuestion = quiz.nextQuestion;
        this.setState(() {
          stopwatch.start();
          overlayShouldBeVisible = false;
          questionText = currentQuestion.question;
          questionNumber = quiz.questionNumber;
          hasImage = currentQuestion.hasImage;
          questionImagePath = currentQuestion.imageRoute;
          contadorDeSecuencia = 0;
          respuestaSecuencia = ["", "", "", ""];
          answer1 = new AnswerButton(
              currentQuestion.options[0],
              currentQuestion.answer,
                  () => handleAnswer(currentQuestion.options[0]));

          answer2 = new AnswerButton(
              currentQuestion.options[1],
              currentQuestion.answer,
                  () => handleAnswer(currentQuestion.options[1]));

          answer3 = new AnswerButton(
              currentQuestion.options[2],
              currentQuestion.answer,
                  () => handleAnswer(currentQuestion.options[2]));

          answer4 = new AnswerButton(
              currentQuestion.options[3],
              currentQuestion.answer,
                  () => handleAnswer(currentQuestion.options[3]));
        });
      })
          : new Container()
    ],
  );
  return a;
}

Future<Null> capture() async {
  final CameraController tempController = controller;
  controller = null;
  await tempController?.dispose();
  controller = new CameraController(cameraD, ResolutionPreset.high);
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

@override
void dispose() {
  controller.dispose();
  super.dispose();
}
}
