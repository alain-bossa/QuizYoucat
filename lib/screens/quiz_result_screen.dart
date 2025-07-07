import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/models/dto/quiz_result.dart';
import 'package:quiz_youcat/screens/quiz_history_screen.dart';
import 'package:quiz_youcat/widgets/disco_button.dart';

class QuizResultScreen extends StatefulWidget {
  static const routeName = '/quizResult';
  QuizResult result;
  QuizResultScreen(this.result, {Key? key}) : super(key: key);

  @override
  _QuizResultScreenState createState() => _QuizResultScreenState(this.result);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  QuizResult result;
  int totalQuestions = 0;
  double totalCorrect = 0;

  _QuizResultScreenState(this.result);

  @override
  void initState() {
    setState(() {
      totalCorrect = result.totalCorrect;
      totalQuestions = result.quiz.questions.length;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: ThemeHelper.fullScreenBgBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            quizResultInfo(result),
            bottomButtons(),
          ],
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
                Navigator.pushReplacementNamed(
                    context, QuizResultScreen.routeName);
              },
            ),
          ]),
    );
  }

  Widget bottomButtons() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DiscoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Fermer",
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
            width: 150,
            height: 50,
          ),
          DiscoButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, QuizHistoryScreen.routeName);
            },
            child: Text(
              "Historique",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            width: 150,
            height: 50,
            isActive: true,
          ),
        ],
      ),
    );
  }

  Widget quizResultInfo(QuizResult result) {
    String texte = "";
    if (totalCorrect > (totalQuestions - 1)) {
      texte = "Félicitations !";
    } else if (totalCorrect > (totalQuestions / 2)) {
      texte = "Pas mal !";
    } else {
      texte = "Peut mieux faire ...";
    }
    return Column(
      children: [
        Image(
          image: ResizeImage(AssetImage("assets/images/QuizResultBadge.png"),
              width: 500, height: 500),
        ),
        Text(
          texte,
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "Tu as finalisé le quiz",
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          "Ton Score",
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "$totalCorrect/$totalQuestions",
          style: Theme.of(context).textTheme.headline3,
        ),
      ],
    );
  }
}
