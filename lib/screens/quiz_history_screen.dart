import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/models/quiz_history.dart';
import 'package:quiz_youcat/screens/quiz_screen.dart';
import 'package:quiz_youcat/stores/quiz_store.dart';
import 'package:quiz_youcat/widgets/disco_button.dart';
import 'package:quiz_youcat/widgets/screen_header.dart';

class QuizHistoryScreen extends StatefulWidget {
  static const routeName = '/quizHistory';
  const QuizHistoryScreen({Key? key}) : super(key: key);

  @override
  _QuizHistoryScreenState createState() => _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  List<QuizHistory> quizHistoryList = [];
  late QuizStore store;

  @override
  void initState() {
    store = QuizStore();
    store.loadQuizHistoryAsync().then((value) {
      setState(() {
        quizHistoryList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10.0),
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List<QuizHistory>.from(quizHistoryList)
                        .map(
                          (e) => quizHistoryViewItem(e),
                        )
                        .toList(),
                  ),
                ),
              ),
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
                      context, QuizHistoryScreen.routeName);
                },
              ),
            ]),
      ),
    );
  }

  Widget quizHistoryViewItem(QuizHistory quiz) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        decoration: ThemeHelper.roundBoxDeco(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 10),
              child: SizedBox(
                height: 115,
                width: 10,
                child: Container(
                  decoration: ThemeHelper.roundBoxDeco(
                      color: ThemeHelper.primaryColor, radius: 10),
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.quizTitle.isEmpty ? "Question" : quiz.quizTitle,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text("Score: ${quiz.score}",
                        style: TextStyle(
                            color: ThemeHelper.accentColor, fontSize: 18)),
                    Text("temps mis pour répondre : ${quiz.timeTaken}"),
                    Text(
                        "Date: ${quiz.quizDate.day}-${quiz.quizDate.month}-${quiz.quizDate.year} ${quiz.quizDate.hour}:${quiz.quizDate.minute}"),
                  ]),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                DiscoButton(
                    width: 100,
                    height: 50,
                    onPressed: () {
                      store
                          .getQuizByIdAsync(quiz.quizId, quiz.categoryId)
                          .then((value) {
                        if (value != null) {
                          Navigator.pushReplacementNamed(
                              context, QuizScreen.routeName,
                              arguments: value);
                        } else {}
                      });
                    },
                    child: Text("Refaire le quiz")),
              ],
            )
          ],
        ));
  }
}
