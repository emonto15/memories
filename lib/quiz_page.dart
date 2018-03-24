import 'package:flutter/material.dart';

import './utils/question.dart';
import './utils/quiz.dart';

import './UI/answer_button.dart';
import './UI/question_text.dart';
import './UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Alf is human", ["si","no","no se","no respondo"],"no"),
    new Question("En venezuela hay democracia",["si","no","no se","no respondo"],"no"),
    new Question("Flutter es maravilloso", ["si","no","no se","no respondo"],"si")
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(String answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is our main page
          children: <Widget>[
            new QuestionText(questionText, questionNumber),
            new AnswerButton(currentQuestion.options[0],currentQuestion.answer, () => handleAnswer(currentQuestion.options[0])),
            new AnswerButton(currentQuestion.options[1],currentQuestion.answer, () => handleAnswer(currentQuestion.options[1])),
            new AnswerButton(currentQuestion.options[2],currentQuestion.answer, () => handleAnswer(currentQuestion.options[2])),
            new AnswerButton(currentQuestion.options[3],currentQuestion.answer, () => handleAnswer(currentQuestion.options[3]))
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
                overlayShouldBeVisible = false;
                questionText = currentQuestion.question;
                questionNumber = quiz.questionNumber;
              });
            }
        ) : new Container()
      ],
    );
  }
}