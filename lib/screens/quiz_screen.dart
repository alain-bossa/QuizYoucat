import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/extensions.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/models/dto/option_selection.dart';
import 'package:quiz_youcat/models/dto/quiz_result.dart';
import 'package:quiz_youcat/models/option.dart';
import 'package:quiz_youcat/models/question.dart';
import 'package:quiz_youcat/models/quiz.dart';
import 'package:quiz_youcat/models/quiz_history.dart';
import 'package:quiz_youcat/screens/quiz_result_screen.dart';
import 'package:quiz_youcat/services/quiz_engine.dart';
import 'package:quiz_youcat/stores/quiz_store.dart';
import 'package:quiz_youcat/widgets/disco_button.dart';
import 'package:quiz_youcat/widgets/question_option.dart';
import 'package:quiz_youcat/widgets/time_indicator.dart';

import 'home_screen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';
  static int cpt_i = 0; //compteur pour afficher les erreurs
  late Quiz quiz;
  QuizScreen(this.quiz, {Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(quiz);
}

class _QuizScreenState extends State<QuizScreen> with WidgetsBindingObserver {
  late QuizEngine engine;
  late QuizStore store;
  late Quiz quiz;
  Question? question;
  Timer? progressTimer;
  AppLifecycleState? state;

  int _remainingTime = 0;
  Map<int, OptionSelection> _optionSerial = {};

  _QuizScreenState(this.quiz) {
    store = QuizStore();
    engine = QuizEngine(quiz, onNextQuestion, onQuizComplete, onStop);
  }

  @override
  void initState() {
    engine.start();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    this.state = state;
  }

  @override
  void dispose() {
    if (progressTimer != null && progressTimer!.isActive) {
      progressTimer!.cancel();
    }
    engine.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //drawer: navigationDrawer(),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                screenHeader(),
                quizQuestion(),
                questionOptions(),
                quizAnswer(),
                quizProgress(),
                footerButton(),
              ],
            ),
          ),
        ),
        appBar: AppBar(
            title: const Text('Quiz Youcat & Bible'),
            backgroundColor: Color.fromARGB(255, 47, 133, 152),
            actions: [
              IconButton(
                icon: const Icon(Icons.access_time),
                tooltip: 'action à implémenter ...',
                onPressed: () {
                  //premPassage = 0;
                  Navigator.pushReplacementNamed(context, QuizScreen.routeName);
                },
              ),
            ]),
      ),
    );
  }

  Widget screenHeader() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        quiz.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget quizQuestion() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 10),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Text(
        question?.text ?? "",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  Widget questionOptions() {
    return Container(
      alignment: Alignment.center,
      decoration: ThemeHelper.roundBoxDeco(),
      child: Column(
        children: List<Option>.from(question?.options ?? []).map((e) {
          int optionIndex = question!.options.indexOf(e);
          var optWidget = GestureDetector(
            onTap: () {
              setState(() {
                engine.updateAnswer(
                    quiz.questions.indexOf(question!), optionIndex);
                for (int i = 0; i < _optionSerial.length; i++) {
                  _optionSerial[i]!.isSelected = false;
                }
                // AC si la reponse est mauvaise, afficher un message d alerte !!!
                //if (QuizScreen.cpt_i < (quiz.questions.length -1)) {
                //   if (engine.questionAnswer[quiz.questions.indexOf(
                //       question!)] == false) {
                //     // traitement KO
                //     AlertUtil.showAlert(context, "Mauvaise réponse",
                //         question!.reponse);
                //   }
                //}

                //}
                _optionSerial.update(optionIndex, (value) {
                  value.isSelected = true;
                  return value;
                });
                // // si on ne met pas cette tempo, ca boucle sur la page result !
                // if (QuizScreen.cpt_i >= (quiz.questions.length -1)) {
                //   print(QuizScreen.cpt_i);
                //   sleep(const Duration(seconds: 1));
                // }
              });
            },
            child: QuestionOption(
              optionIndex,
              _optionSerial[optionIndex]!.optionText,
              e.text,
              isSelected: _optionSerial[optionIndex]!.isSelected,
            ),
          );
          return optWidget;
        }).toList(),
      ),
    );
  }

  Widget quizProgress() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16),
            child: TimeIndicator(
              question?.duration ?? 1,
              _remainingTime,
              () {},
            ),
          ),
          Text(
            "$_remainingTime Secondes",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget quizAnswer() {
    String reponse = "";
    if (engine.questionAnswer[quiz.questions.indexOf(question!)] == false) {
      reponse = question!.reponse;
    }
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "La réponse est :    " + reponse,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget footerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DiscoButton(
          onPressed: () {
            setState(() {
              QuizScreen.cpt_i = 0;
              engine.stop();
              if (progressTimer != null && progressTimer!.isActive) {
                progressTimer!.cancel();
              }
            });
            Navigator.pop(context);
          },
          child: Text(
            "Annule",
            style: TextStyle(fontSize: 16),
          ),
          width: 130,
          height: 50,
        ),
        DiscoButton(
          onPressed: () {
            // AC incremente le compteur
            QuizScreen.cpt_i = QuizScreen.cpt_i + 1;
            engine.next();
          },
          child: Text(
            "Suivant",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          isActive: true,
          width: 130,
          height: 50,
        ),
      ],
    );
  }

  void onNextQuestion(Question question) {
    setState(() {
      if (progressTimer != null && progressTimer!.isActive) {
        _remainingTime = 0;
        progressTimer!.cancel();
      }

      this.question = question;
      if (HomeScreen.animateur ==
          "oui") //AC TODO C'est ici qu'on neutralise le timer
        _remainingTime = 9000;
      else
        _remainingTime = question.duration;

      _optionSerial = {};
      for (var i = 0; i < question.options.length; i++) {
        _optionSerial[i] = OptionSelection(String.fromCharCode(65 + i), false);
      }
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime >= 0) {
        try {
          if (mounted) {
            setState(() {
              progressTimer = timer;
              _remainingTime--;
            });
          }
        } catch (ex) {
          timer.cancel();
          print(ex.toString());
        }
      }
    });
  }

  void onQuizComplete(Quiz quiz, double total, Duration takenTime) {
    if (mounted) {
      setState(() {
        _remainingTime = 0;
      });
    }
    QuizScreen.cpt_i = 0;
    progressTimer!.cancel();
    store.getCategoryAsync(quiz.categoryId).then((category) {
      store
          .saveQuizHistory(QuizHistory(
              quiz.id,
              quiz.title,
              category.id,
              "$total/${quiz.questions.length}",
              takenTime.format(),
              DateTime.now(),
              "Complete"))
          .then((value) {
        Navigator.pushReplacementNamed(context, QuizResultScreen.routeName,
            arguments: QuizResult(quiz, total));
      });
    });
  }

  void onStop(Quiz quiz) {
    _remainingTime = 0;
    progressTimer!.cancel();
  }
}
