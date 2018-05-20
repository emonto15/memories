import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:memories/Constants.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:clock/clock.dart' as clock;
import 'package:collection/collection.dart';
import 'package:countdown/countdown.dart';
import 'package:memories/tts.dart';
import 'package:memories/main.dart';

import './utils/question.dart';
import './utils/quiz.dart';

import './UI/answer_button.dart';
import './UI/question_text.dart';
import './UI/correct_wrong_overlay.dart';

import './Score_page.dart';

class QuizPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String googleId;

  QuizPage({this.cameras, this.googleId});

  @override
  State createState() => new QuizPageState(cameras: cameras);
}

class QuizPageState extends State<QuizPage> {
  final List<CameraDescription> cameras;
  CountDown cdAlert;
  CountDown cdStart;
  CountDown cdStop;
  StreamSubscription subAlert;
  StreamSubscription subStart;
  StreamSubscription subStop;

  QuizPageState({this.cameras});

  Function eq = const ListEquality().equals;
  CameraDescription cameraD;
  static const platform = const MethodChannel('co.edu.eafit.dis.p2.memories');
  bool opening = false;
  CameraController controller;
  String imagePath;
  int pictureCount = 0;
  var emotion = new List();
  var isDistracted = false;
  var isSad = true;
  var cont = 0;
  String lastResponse = "";

  Question currentQuestion;
  Quiz quiz;
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
      String a = await platform
          .invokeMethod('sendEmotion', <String, dynamic>{"path": path});
      setState(() {
        lastResponse = a;
        print(e);
        emotion = json.decode(lastResponse);
        var max = 0.0;
        var aux = "";
        emotion[0]["faceAttributes"]["emotion"].forEach((k, v) {
          if (max < v) {
            max = v;
            aux = k;
          }
        });
        print(max);
        if (aux == "" ||
            aux == "anger" ||
            aux == "contempt" ||
            aux == "disgust" ||
            aux == "fear" ||
            aux == "sadness") {
          isSad = true;
        }
      });
      print("Desde flutter:" + a);
    } on PlatformException catch (e) {
      print("Failed to send emotion: '${e.message}'.");
    }
  }

  void _dialogAction(bool seguir) {
    if(seguir){
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>
          new MyTabs(widget.googleId)));
    }
  }

  void countDown() async {
    if (isSad) {
      print("countdown() called");
      cdAlert = new CountDown(new Duration(seconds: 15));
      subAlert = cdAlert.stream.listen(null);
      cdStart = new CountDown(new Duration(seconds: 20));
      subStart = cdStart.stream.listen(null);
      subAlert.onDone(() {
        Tts.speak("Vamos tu puedes");
      });
      subStart.onDone(() async {
        var time = await platform.invokeMethod('distraccion');
        print(time);
        cdStop = new CountDown(new Duration(seconds: 10));
        subStop = cdStop.stream.listen(null);
        subStop.onDone(() async {
          print("JOCO");
          var time1 = await platform.invokeMethod('finDistraccion');
          AlertDialog dialog = new AlertDialog(
            content: new Text(
                "¿Deseas continuar con la sesión?",
                style: new TextStyle(fontSize: 20.0)
            ),
            actions: <Widget>[
              new FlatButton(onPressed: () {_dialogAction(true);}, child: new Text("Si!")),
              new FlatButton(onPressed: () {_dialogAction(false);}, child: new Text("No"))
            ],
          );
          showDialog(context: context, builder: (BuildContext context) => dialog);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getQuizQuestions();
    currentQuestion = new Question(
        "Cargando...", ["", "", "", ""], "", false, "", false, [], 1, 2);
    questionText = currentQuestion.question;
    questionNumber = 0;
    hasImage = currentQuestion.hasImage;
    questionImagePath = currentQuestion.imageRoute;
    stopwatch.start();
    contadorDeSecuencia = 0;
    respuestaSecuencia = ["", "", "", ""];
    answer1 = new AnswerButton(currentQuestion.options[0],
        currentQuestion.answer, () => handleAnswer(currentQuestion.options[0]));

    answer2 = new AnswerButton(currentQuestion.options[1],
        currentQuestion.answer, () => handleAnswer(currentQuestion.options[1]));

    answer3 = new AnswerButton(currentQuestion.options[2],
        currentQuestion.answer, () => handleAnswer(currentQuestion.options[2]));

    answer4 = new AnswerButton(currentQuestion.options[3],
        currentQuestion.answer, () => handleAnswer(currentQuestion.options[3]));
    countDown();
  }

  void handleAnswer(String answer) {
    Tts.flush();
    if (isSad && cdAlert != null) {
      subAlert.cancel();
      subStart.cancel();
      if (subStop != null) {
        var time = platform.invokeMethod('finDistraccion');
        print(time);
        subStop.cancel();
      }
    }
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
        if (respuestaSecuencia.indexOf(answer) == -1) {
          if (currentQuestion.options.indexOf(answer) == 0) {
            answer1 = new AnswerButton(
                (contadorDeSecuencia + 1).toString() +
                    " - " +
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
              print((stopwatch.elapsedMilliseconds / 1000).toString() +
                  "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 1) {
            answer2 = new AnswerButton(
                (contadorDeSecuencia + 1).toString() +
                    " - " +
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
              print((stopwatch.elapsedMilliseconds / 1000).toString() +
                  "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 2) {
            answer3 = new AnswerButton(
                (contadorDeSecuencia + 1).toString() +
                    " - " +
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
              print((stopwatch.elapsedMilliseconds / 1000).toString() +
                  "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
          if (currentQuestion.options.indexOf(answer) == 3) {
            answer4 = new AnswerButton(
                (contadorDeSecuencia + 1).toString() +
                    " - " +
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
              print((stopwatch.elapsedMilliseconds / 1000).toString() +
                  "seconds");
              stopwatch.reset();
              overlayShouldBeVisible = true;
            }
          }
        }
      });
    }
    print(currentQuestion.options.indexOf(answer));
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
                  new Row(children: <Widget>[answer1, answer2]),
                  new Row(children: <Widget>[answer3, answer4])
                ])
          ],
        ),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == questionNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new ScorePage(
                              quiz.score, quiz.length, widget.googleId)),
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
                  countDown();
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

  Future<Null> getQuizQuestions() async {
    try {
      var test = {"google_id": widget.googleId};
      var httpClient = new HttpClient();
      final String requestBody = json.encode(test);
      print(requestBody);
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(URL + '/users/nextQuiz'))
            ..headers.add(HttpHeaders.ACCEPT, ContentType.JSON)
            ..headers.contentType = ContentType.JSON
            ..headers.contentLength = requestBody.length
            ..headers.chunkedTransferEncoding = false;
      request.write(requestBody);
      HttpClientResponse response = await request.close();

      var nuevoMapa = new List();

      nuevoMapa = json.decode(await response.transform(utf8.decoder).join());
      print(nuevoMapa[0]);
      setState(() {
        List<Question> questionsarray = [];
        for (int i = 0; i < nuevoMapa.length; i++) {
          if (nuevoMapa[i]["ifSec"]) {
            print("Entre ifsec");
            questionsarray.add(new Question(
                nuevoMapa[i]["pregunta"],
                nuevoMapa[i]["opciones"],
                "",
                false,
                "",
                true,
                nuevoMapa[i]["respuestaSec"],
                nuevoMapa[i]["area"],
                nuevoMapa[i]["subArea"]));
          } else {
            if (nuevoMapa[i]["imagen"]) {
              print("Entre imagen");
              questionsarray.add(new Question(
                  nuevoMapa[i]["pregunta"],
                  nuevoMapa[i]["opciones"],
                  nuevoMapa[i]["respuestaSel"],
                  true,
                  "assets/zebra256.webp",
                  false,
                  [],
                  nuevoMapa[i]["area"],
                  nuevoMapa[i]["subArea"]));
            } else {
              print("Entre despues");
              questionsarray.add(new Question(
                  nuevoMapa[i]["pregunta"],
                  nuevoMapa[i]["opciones"],
                  nuevoMapa[i]["respuestaSel"],
                  false,
                  "",
                  false,
                  [],
                  nuevoMapa[i]["area"],
                  nuevoMapa[i]["subArea"]));
            }
          }
        }
        this.quiz = new Quiz(questionsarray);
        currentQuestion = quiz.nextQuestion;
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
    } catch (err) {
      print(err);
    }
  }
}
